Общее описание
---------------
Файл проекта предназначен для описания свойств конкретного проекта.
Но основе этого файла происходит разворачивание и настройка системы под проект.
В частности, на основе этого файла генерируются Dockerfile-ы для всех указанных узлов,
а так же общий docker-compose.yml для запуска всего проекта.

Структура файла проекта
------------------------
Файл проекта представляет из себя файл в формате yaml и имеет следующую структуру:
```yaml
version: 0.3

project:
..глобальные настройки..

  groups:
    group1:
      nodes:
         builder:
            ..параметры для узла сборки проекта..
     
         tester:
            ..параметры для узла тестирования..
      
    group2:
      ..общие параметры для узлов типа "group2"..
     
      nodes:
        node1:
           ..параметры для узла node1
        node2:
           ..параметры для узла node2
        nodeX:
         ..
```
В начале должна быть указана версия (текущая поддерживаемая **"0.3"**), а сам проект описывается в разделе **project:**

Полный пример файла проекта можно посмотреть здесь: [example-project.yml](utils/example-project.yml)


Общие параметры описания проекта:
---------------------------------
Структура имеет следующий вид
```yaml

project:
  name: "myproject"
  networks:
    net1: { subnet: "192.168.81", gateway: "100" }
    net2: { subnet: "192.168.82", gateway: "100" }
    ...
    netX: { subnet: "192.168.83", gateway: "100" }
 
  logdb:
    ... logdb parameters..(необязательные настройки)

  nginx:
    ... nginx parameters..(необязательные настройки)
    
  vstand:
    ...необязательные настройки для работы с виртуальным стендом
    .. переопределяют стендовые настройки
```

* **name** - название проекта
* **networks** - список подсетей которые будут доступны на узле. 
Обратите внимание, что задаются не ip адреса, а именно подсети.
* **gateway** - задаёт ip шлюза.

см. так же [networks](docs/networks.md)


Области задания общих параметров
---------------------------------
Существует три области задания параметров.

* Глобальная (задействуется для всех узлов в проекте)

```yaml
project:
  name: projectname
  ...global paramaters..
```

* Параметры для всех узлов группы

```yaml
  group1:
   ..parameters for all nodes in group1..
 
  group2:
   ..parameters for all nodes in group2..
```

* Уровень конкретного узла

```yaml
  group1:
    ..
    nodes:
      node1:
        ..параметры конкретного узла..
      node2:
        ..параметры конкретного узла..
```
Итоговые параметры попадающие в Dockerfile и docker-compose.yml складываются из этих трёх областей.


Доступные параметры
--------------------
```yaml
...

project_compose_template: 'my-compose-template.yml.tpl'
node_compose_template: 'my-node-compose-template.yml.tpl'

volumes:
  - /var/run/docker.sock:/var/run/docker.sock

devices:
  - /rmp/dev1:/tmp/dev1

apt:
   packages:
     - mc
     - libuniset2
   sources:
     - "rpm http://ftp.etersoft.ru/pub ALTLinux/p8/branch/x86_64 classic"
     - "rpm http://ftp.etersoft.ru/pub ALTLinux/p8/branch/noarch classic"

start_command: "start-project.sh"

copy:
   - '[a+r]testfile.copy:/tmp/testfile'
   - '[a+rw]testfile2.copy:/tmp/'
    
before_command:
   - rpm -Uhv myproejct.rpm
   - myproject-config config
   - ...
    
env_file:
   - file1.env
   - file2.env

environment:
   - VAR1=VAL1
   - VAR2=VAL2
    
ports:
   - port1:port2
   - port3:port3
   - port4:port5
```
* **volumes** - Задаёт список проброса каталогов, который попадает в генерируемый docker-compose.yml (см. также [volumes](docs/volumes.md))
* **devices** - Задаёт список проброса устройств, который попадает в генерируемый docker-compose.yml
* **ports** - список пробрасываемых портов, который попадает в генерируемый docker-compose.yml

* **apt** - секция задающая параметры для [apt](docs/apt.md)
  * **packages** - список пакетов, которые необходимо установить. В итоговый Dockerfile попадает команда 
            apt-get install ..packages..
  * **sources** - задаёт список репозиториев. В итоге в контейнер генерируется файл /etc/apt/sources.list.d/sources.list с указанным списком.
* **start_command** - *CMD* попадающая в итоговый Dockerfile.
* **copy** - задаёт список файлов которые будут скопированы в контейнер на этапе сборки образа. Позволяет указать права
на получающийся файл **"[mode]src:dest"**. В итоге каждый элемент преобразуется в команды: 
```
 COPY src dest
 RUN chmod mode dest
```
* **before_command** - команды преобразуемые в *RUN* в Dockerfile.
* **env_file** - Файлы с переменными окружения для контейнера. Итоговые настройки напрямую попадают в docker-compose.yml
* **environment** - переменные окружения для контейнера. Итоговые настройки напрямую попадают в docker-compose.yml

Дополнительно для конкретного узла или группы узлов можно указать параметр
```yaml
  node1:
    skip_compose: yes
```
или
```yaml
  group1:
    skip_compose: yes
    nodes:
       ...
```
Такой узел или группа узлов не будут включены в итоговый docker-compose.yml

* **project_compose_template** - позволяет задать свой шаблон для docker-compose.yml файла. Не является обязательным параметром.

* **node_compose_template** - позволяет задать свой шаблон для docker-compose.yml файла генерируемого, для конкретного узла. Этот параметр может быть задан 'глобально', 'для группы', 'для конкретного узла'. Это параметр не является обязательным.

Параметры узла (node)
---------------------
В случае если используется "статическая сеть" (см. [network](docs/network.md))
для каждого узла обязательно должен быть указан 'ip'. При этом задаётся только "последняя" цифра адреса.
Итоговый адрес формируется на основе секции 'networks' как **subnet.ip**
Пример:
```yaml
 groupX:
   nodes:
     mynode1: 
       ip: 1
       ssh_port: 10001
       ssh_internal_port: 32
       .. другие параметры переопределяющие или дополняющие глобальные для проекта и групповые..
       apt:
         packages:
           - openssh-server

       logservers:
         - { name: "logserver1", port: 3333, cmd: "-s level1", description: 'Процесс управления N1' }
         - { name: "logserver2", port: 4444, cmd: "-s level2", description: 'Процесс управления N2' }

     mynode2: { ip: 2 }
     mynode3: { ip: 3, vnc_port: 5900, novnc_port: 6900, ssh_port: 10003 }
```
Свойств **vnc_port** и **novnc_port** не является обязательными.
Если задан **vnc_port** то в итоговый docker-compose.yml этот порт добавляется в секцию **ports:**.
Если помимо *vnc_port* задаётся и **novnc_port**, но при настройке виртуального стенда,
этот порт будет использован как порт подключения к стенду "снаружи". См. так же раздел [novnc](docs/novnc.md)

**ssh_port** - Задаёт внешний порт (на машине стенда) который будет проброшен для доступа к контейнеру по ssh.
Не обязательный параметр 'ssh_internal_port' задаёт куда пробрасывать. По умолчанию: ssh_internal_port=22
См. так же раздел [ssh](docs/ssh.md)

**logservers** - не обязательный параметр задающий список логсерверов для данного узла,
которые будут опрашиваться [logdb](docs/logdb.md) и логи будут доступны через web-интерфейс
http://stand-node/logdb/ws
