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
- devops-api-server (для интерграции с jenkins, bugzilla, youtrack и т.п.)
- какая-то backup система
- мониторинг (grafana + netdata)

Концепция:
----------
Для того, чтобы обеспечить наличие независимой сети для каждого тестового стенда (узлы сети могут иметь одинаковые ip), 
стенды запускаются внутри ВМ (virtualbox) с виртуальной сетью. При этом чтобы обеспечить лёгкость запуска и сопровождения
самих узлов используется docker. Поэтому основная идея: docker запускается внутри ВМ, при этом тестовый стенд
работает с виртуальной сетью внутри ВМ (сеть наружу не выходит). 
Имеется базовый преднастроенный образ ВМ тестового стенда. Для создания нового стенда под проект используется
ansible и vagrant. 

Алгоритм запуска нового стенда
-------------------------------
Gitlab CI (или вручную) запускает ansible сценарий, который:
- (vagrant) на указанной выделенной машине запускает новую ВМ (разворачивая из заранне готового базового образа)
- преднастраивает в ней локальный регистр (docker-registry)
-- конфигурирует его
-- обновляет в нём нужные базовые образы до указанных версий (либо до последних)
- регистрирует в Gilab CI новые gitlab-runner-ы
- выставляет указанные для стенда лимиты (сколько процессоров, сколько памяти на весь стенд(!))
- преднастраивает ВМ под нужный проект
-- по специальному описанию проекта (yaml файл) генерирует Dockerfile-ы для узлов входящих в проект
-- собирает docker-образы (на основе базовых)
-- генерирует специальный сборочный docker
- настраивает внутреннуюю виртуальную сеть (ip) 
- преднастраивает необходимые сервисы для доступа и мониторинга к ВМ снаружи
- преднастраивает необходимые внутренний сервисы для архивирования артефактов тестирования и т.п.



==================================
Технические детали создания

1. создал ВМ с docker-ом внутри
  - внутри создал пользователя vadmin (в /etc/sudoers.d прописал ему права на docker,su -и т.п.)
  - установил всякие пакеты типа wget,curl,htop,iotop,pip,docker-compose,cfdisk
  - # cgroup iptables
  - # git-core
  - # etersoft-build-utils
  - отдельно установил etcgit 
  - control sudo public
  - добавить docker-builder в группу docker!
  - если не поднимать свой docker-registry, то нужно чтобы на машине был дотупен inet для скачивания образов
  (либо надо зараннее стенд готовить)
  - нужно поднять сертификаты, чтобы работа шла по https
  - вообще должен работать dns

  rpmgp -i - установка зависимостей указанных в spec файле
 
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
По инструкции: https://wiki.office.etersoft.ru/Gitlab_ci

пришлось добавить в config.toml
environment = ["TERM=ansi"]

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
  [runners.cache]

[[runners]]
  name = "vstand p8"
  url = "http://gitlab-server:30080/ci"
  token = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxx"
  environment = ["TERM=xterm"]
  executor = "shell"


5. Создал service-файл для gitlab-runner
[Unit]
Description=GitLab Runner
After=syslog.target network.target
ConditionFileIsExecutable=/usr/bin/gitlab-runner

[Service]
StartLimitInterval=5
StartLimitBurst=10
ExecStart=/usr/bin/gitlab-runner "run" "--working-directory" "/home/vadmin" "--config" ".gitlab-runner/config.toml"
.
Restart=always
RestartSec=120
User=vadmin

[Install]
WantedBy=multi-user.target

-----------------------------------------------------
НАСТРОЙКА СВОЕГО DOCKER-REGISTRY (https://docs.docker.com/registry/)
-----------------------------------------------------
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
 

.. Назначил новому проекту (в настройках gitlab/admin/runners) этот runner
========================================================================================
СЛОЖНОСТИ ЗАПУСКА СБОКИ c gitlab-runner executer="docker"
- Пользователь внутри docker - root. Сборка под root запрещена в rpmbuilder и rpmbb (по умолчанию)
