Общее описание
---------------
Файл проекта предназначен для описания свойств конкретного проекта.
Но основе этого файла происходит разворачивание и настройка системы под конкретный проект.
В частности, на основе этого файла генерируются Dockerfile-ы для всех указанных узлов,
а так же общий docker-compose.yml для запуска всего проекта в docker.


Структура файла проекта
------------------------
Файл проекта представляет из себя файл в формате yaml и имеет следующую структуру:

project:
  ..общие параметры..
  
  ..глобальные настройки..
  
  builder:
     ..параметры для узла сборки проекта..
     
  tester:
     ..параметры для узла тестирования..
     
  controllers:
     ..общие параметры для узлов типа "контроллер"..
     
     nodes:
        - node1
           ..параметры для узла node1
        - node2
           ..параметры для узла node2
        - nodeX
           ..
           
   gui:
     ..общие параметры для узлов типа "gui"..
     
     nodes:
        - guinode1
           ..параметры для узла guinode1
        - guinode2
           ..параметры для узла guinode2
        - guinodeX
           ..

Общие параметры описания проекта:
---------------------------------
Структура имеет следующий вид
project:
  name: "myproject"
  networks:
      net1: "192.168.81"
      net2: "192.168.82"
      netX: "192.168.83"
 
  image:
    controller: x64.p8-controller
    gui: x64.p8-gui
    builder: x64.p8-builder
    tester: x64.p8-tester

name - название проекта
networks - список подсетей которые будут доступны на узле. Обратите внимание, что задаются не ip адреса, а именно подсети.
image - задаёт названия шаблонов по которым будет генерироваться Dockerfile соответствующих типов узлов.
Итоговое имя (jinja2) шаблона формируется как Dockerfile._image_name_.tpl 

Области задания общих параметров
---------------------------------
Существует три области задания параметров.

1. Глобальная (задействуется для всех узлов в проекте)
project:
   ...global paramaters..

2. Параметры для всех узлов конкретного типа

project:
   ...
 
   controllers:
      ..parameters for all controllers..
 
   gui:
      ..parameters for all gui nodes..

3. Уровень конкретного узла

project:
   ...
 
   controllers:
      ..
      nodes:
         - node1
            ..параметры конкретного узла..
         - node2
            ..параметры конкретного узла..

Итоговые параметры попадающие в Dockerfile узла и docker-compose.yml складываются
из этих трёх областей.
            

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
    
volumes - Задаёт список проброса каталогов, который попадает в генерируемый docker-compose.yml
devices - Задаёт список проброса устройств, который попадает в генерируемый docker-compose.yml

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
