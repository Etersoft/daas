Общее описание
---------------
Файл проекта предназначен для описания свойств конкретного проекта.
Но основе этого файла происходит разворачивание и настройка системы под конкретный проект.
В частности, на основе этого файла генерируются Dockerfile-ы для всех указанных узлов,
а так же общий docker-compose.yml для запуска всего проекта в docker.


Структура файла проекта
------------------------
Файл проекта представляет из себя файл в формате yaml и имеет следующую структуру:

version: 0.2

..общие параметры..

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
        - node1
           ..параметры для узла node1
        - node2
           ..параметры для узла node2
        - nodeX
           ..

Общие параметры описания проекта:
---------------------------------
Структура имеет следующий вид

name: "myproject"
networks:
  net1: { subnet: "192.168.81", gateway: "100" }
  net2: { subnet: "192.168.82", gateway: "100" }
  ...
  netX: { subnet: "192.168.83", gateway: "100" }
 

name - название проекта
networks - список подсетей которые будут доступны на узле. 
Обратите внимание, что задаются не ip адреса, а именно подсети.
gateway - задаёт ip шлюза.

Области задания общих параметров
---------------------------------
Существует три области задания параметров.

1. Глобальная (задействуется для всех узлов в проекте)

...global paramaters..

2. Параметры для всех узлов группы
 
  group1:
      ..parameters for all nodes in group1..
 
  group2:
      ..parameters for all nodes in group2..

3. Уровень конкретного узла

   group1:
      ..
      nodes:
         - node1
            ..параметры конкретного узла..
         - node2
            ..параметры конкретного узла..

Итоговые параметры попадающие в Dockerfile узла и docker-compose.yml складываются из этих трёх областей.
            

Доступные параметры
--------------------
  ...

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
    
volumes - Задаёт список проброса каталогов, который попадает в генерируемый docker-compose.yml
devices - Задаёт список проброса устройств, который попадает в генерируемый docker-compose.yml
ports - список пробрасываемых портов, который попадает в генерируемый docker-compose.yml

apt - секция задающая параметры для apt
  packages - список пакетов, которые необходимо установить. В итоговый Dockerfile попадает команда apt-get install ..packages..
  sources - задаёт список репозиториев. В итоге в контейнер генерируется файл /etc/apt/sources.list.d/sources.list с указанным списком.

start_command - CMD попадающая в итоговый Dockerfile.

copy - задаёт список файлов которые будут скопированы в контейнер на этапе сборки образа. Позволяет указать права
на получающийся файл "[mode]src:dest".
В итоге каждый элемент преобразуется в команды: 
COPY src dest
RUN chmod xxxx dest

before_command - команды преобразуемые в RUN в Dockerfile.
env_file - Файлы с переменными окружения для контейнера. Итоговые настройки напрямую попадают в docker-compose.yml
environment - переменные окружения для контейнера. Итоговые настройки напрямую попадают в docker-compose.yml

Дополнительно для конкретного узла или группы узлов можно указать параметр
  node1:
    skip_compose: yes
или
  group1:
    skip_compose: yes
    nodes:
       ...

Такой узел или группа узлов не будут включены в итоговый docker-compose.yml

Параметры узла (node)
---------------------
К обязательным параметрам которые должны быть заданы для каждого узла 
относится 'ip'. При этом задаётся только "последняя" цифра адреса.
Итоговый адрес формируется на основе секции 'networks' как {{subnet}}.{{ip}}
Пример:

groupX:
  nodes:
    mynode1: 
      ip: 1
      .. другие параметры переопределяющие или дополняющие глобальные для проекта и групповые..
      apt:
	packages:
	  - openssh-server

    mynode2: { ip: 2 }
    mynode3: { ip: 3, vnc_port: 5900, novnc_port: 6900 }

Свойства 'vnc_port' и novnc_port не является обязательными.
Если задан 'vnc_port' то в итоговый docker-compose.yml этот порт добавляется в секцию 'ports:'.
Если помимо vnc_port задаётся и novnc_port, но при настройке виртуального стенда,
этот порт будет использован как порт подключения к стенду "снаружи". См. так же раздел 
документации по VNC (vnc.md).

