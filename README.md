DaaS - "devops as a service" - это такой преднастроенный (но конфигурируемый если надо) набор сервисов,
позволяющих быстро организовать devops.

Задача
======
Создать преднастроенную систему взаимодествующих между собой сервисов для организации CI/CD
в небольшой по размеру команде разработчиков. Сервисы должны легко запускаться и конфигурироваться,
Лего мониторится, и по возможности легко переезжать на новое железо.
Должны быть предусмотрены backup-ы критичных данных и возможность быстрого восстановления.
Тестовые стенды под тот или иной проект должны разворачиваться "по нажатию одной кнопки",
должна быть предусмотрена возможность запустить столько тестовых стендов одного проекта,
сколько понадобиться.

Архитектура
===========
Состав сервисов:
----------------
- Gitlab
- bugtracker (надо ли)
- ВМ c docker (для развёртывания виртуальных тестовых стендов в замкнутой сети)
- ansible
- devops-api-server - REST API(единая точка входа для интерграции с jenkins, bugzilla, youtrack и т.п.)
- какая-то backup система
- мониторинг (grafana + netdata)
- свой dns внутри ВМ для сервисов(?)

Концепция:
----------
Для того, чтобы обеспечить наличие независимой сети для каждого тестового стенда (разные проекты могут иметь одинаковые ip), 
стенды запускаются внутри ВМ (virtualbox) с виртуальной сетью. При этом чтобы обеспечить лёгкость запуска и сопровождения
самих узлов используется docker. Поэтому основная идея: docker запускается внутри ВМ, при этом тестовый стенд
работает с виртуальной сетью внутри ВМ (сеть наружу не выходит). 
Имеется базовый преднастроенный образ ВМ тестового стенда. Для создания нового стенда под конкретный проект используется
ansible и vagrant, которые на основе базового образа ВМ преднастраивают сервисы и всё необходимое для конкретного проекта. 

debops-api-server
------------------
Это сервис с REST API, позволяющий единообразно общаться между разными сервисами.
Например запустить задачу в jenkins, поменять статус задачи или создать новую в youtrack, gitlab, bugzilla
и т.п. Его цель предоставить единый интерфейс к "разношёрстным" сервисам.
Т.к. многие продукты и так умеют работать между собой (gilab + jenkins, jenkins + youtrack),
то возможно этот слой "абстракции является лишним", с другой если есть единый неизменный интерфейс
и все работают только через него, то изменения в API сторонних программ (gitlab, jenkins, youtrack и т.п.)
не будут затрагивать работу, т.к. будет корректироваться только реализация общения с конкретным
изменившимся API. Минусом зато является поддержка всего этого.


Алгоритм запуска нового стенда
-------------------------------
Gitlab CI (или вручную) запускает ansible сценарий, который:
- (vagrant) на указанной выделенной машине запускает новую ВМ (разворачивая из заранне готового базового образа)
- преднастраивает в ней локальный регистр (docker-registry)
-- конфигурирует его
-- обновляет в нём нужные базовые docker-образы до указанных версий (либо до последних)
- регистрирует в Gilab CI новые gitlab-runner-ы
- выставляет указанные для стенда лимиты (сколько процессоров, сколько памяти на весь стенд(!))
- преднастраивает ВМ под нужный проект
-- по специальному описанию проекта (yaml файл) генерирует Dockerfile-ы для узлов входящих в проект
-- собирает docker-образы (на основе базовых)
-- генерирует специальный сборочный docker
- настраивает внутреннуюю виртуальную сеть (ip) 
- преднастраивает необходимые сервисы для доступа и мониторинга к ВМ снаружи
- преднастраивает необходимые внутренние сервисы для архивирования артефактов тестирования и т.п.




Технические заметки в процессе работы над проектом:
===================================================
1. создал ВМ с docker-ом внутри
  - внутри создал пользователя vadmin (в /etc/sudoers.d прописал ему права на docker,su -и т.п.)
  - добавил vadmin в группу docker
  - установил всякие пакеты типа wget,curl,htop,iotop,pip,docker-compose,cfdisk,python-module-jinja2,apt-repo-tools
  - # cgroup iptables
  - # git-core
  - # etersoft-build-utils
  - отдельно установил etcgit 
  - control sudo public
  - если не поднимать свой docker-registry, то нужно чтобы на машине был доcтупен inet для скачивания образов
  (либо надо зараннее стенд готовить)
  - нужно поднять сертификаты, чтобы работа шла по https
  - вообще должен работать dns

  rpmgp -i - установка зависимостей указанных в spec файле
  rpmgp -l | epm --skip-installed --auto install  <-- установить только то, что не стоит
 
  docker-compose должен быть версии > 1.11.2 && < 1.19.0 (в p8 1.6.2, поэтому пришлось ставить при помощи pip)
  я ставил: pip install docker-compose==1.18.0
  
  docker тоже обновил через pip
 
 
1.0 ВМ имеет три сети (1 - мост в реальную, 2,3 - виртуальная внутреняя сеть)
 - нужно привязать к busid
 
1.1 Создал пользователя vadmin
vadmin ALL=(ALL) NOPASSWD: /bin/su, /bin/sudo, /usr/bin/docker
добавил его в группу docker

2. отдельно запустил gitlab внутри docker

sudo docker run --detach \
    --hostname gitlab.example.com \
    --publish 30080:30080 \
    --publish 30022:22 \
    --publish 30443:443 \
    -c 512 \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://pvbook:30080'; gitlab_rails['gitlab_shell_ssh_port']=30022;" \
    --name gitlab \
    --restart always \
    --volume /home/pv/docker-tests/gitlab/config:/etc/gitlab \
    --volume /home/pv/docker-tests/gitlab/logs:/var/log/gitlab \
    --volume /home/pv/docker-tests/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest

    
3. Скачал и установил последний gitlab-runner (т.к. старый не работает с новым gitlab)
wget -O /usr/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

4. Зарегистрировал gitlab-runner в gitlab

# Простой пример: gitlab-runner register --name my-runner --url http://gitlab.example.com --registration-token my-registration-token
По инструкции: https://wiki.office.etersoft.ru/Gitlab_ci

пришлось добавить в config.toml
environment = ["TERM=ansi"]

sudo usermod -aG docker gitlab-runner

В одном config два runner (docker и shell). Запускаются под vadmin
-------------------------------------------------------------------
concurrent = 2
check_interval = 0

[[runners]]
  name = "docker-builder-p8"
  url = "http://gitlab-server:30080/ci"
  token = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxx"
  executor = "docker"
  [runners.docker]
     tls_verify = false
     image = "vpashka/builder-p8"
     privileged = true
     disable_cache = false
     shm_size = 0
     volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
     extra_hosts = ["pvbook:192.168.1.3"]
     allowed_images = ["local-docker-registry:5000/*:*"]
  [runners.cache]

[[runners]]
  name = "vstand p8"
  url = "http://gitlab-server:30080/ci"
  token = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxx"
  environment = ["TERM=xterm"]
  executor = "shell"

СЛОЖНОСТИ ЗАПУСКА СБОРКИ c gitlab-runner executer="docker"
- Пользователь внутри docker - root. Сборка под root запрещена в rpmbuilder и rpmbb (по умолчанию)

5. Создал service-файл для gitlab-runner (лежит в git)

6. НАСТРОЙКА СВОЕГО DOCKER-REGISTRY (https://docs.docker.com/registry/)
------------------------------------------------------------------------
    docker pull docker/dtr:2.4.2

    docker run -d -p 5000:5000 -e REGISTRY_HTTP_ADDR=0.0.0.0:5000 --restart=always --name registry -v /srv/registry:/var/lib/registry registry:2

Для доступа без сертификатов,
надо в /etc/docker/ создать файл daemon.json с таким содержимым
    { "insecure-registries":["local-docker-registry:5000"] }


НО ПРАВИЛЬНЕЕ НАСТРАИВАТЬ С СЕРТИФИКАТАМИ:
DOCS: https://docs.docker.com/registry/deploying/#get-a-certificate

    mkdir -p certs

Copy the .crt and .key files from the CA into the certs directory. 
The following steps assume that the files are named domain.crt and domain.key.

     $ docker run -d \
	--restart=always \
	--name registry \
	-v `pwd`/certs:/certs \
	-e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
	-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
	-e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
	-p 443:443 \
	registry:2
 

7. Проброс устройств внутрь docker

    docker run --privileged --cap-add=ALL -v /dev:/dev  -v  /lib/modules:/lib/modules ...

Много интересных настроек: https://gitlab.com/gitlab-org/gitlab-runner/blob/master/docs/configuration/advanced-configuration.md



--------------
Правки вновь запущенного шаблонного vstand:

- перерегистрировать gitlab-runner-ов в gitlab
- исправить /etc/hosts  на предмет доступа по hostname gitlab-server
- переименовать машину (hostname) под проект (/etc/sysconfig/network и hostnamectl set-hostname <HOSTNAME>)
