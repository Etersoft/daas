Технические заметки в процессе работы над проектом:
===================================================
1. создал ВМ с docker-ом внутри
  - внутри создал пользователя vadmin (в /etc/sudoers.d прописал ему права на docker,su -и т.п.)
  - добавил vadmin в группу docker
  - установил всякие пакеты типа wget,curl,htop,iotop,pip,docker-compose,cfdisk,python-module-jinja2,apt-repo-tools,unzip
  - # cgroup iptables
  - # git-core
  - # etersoft-build-utils
  - отдельно установил etcgit 
  - control sudo public
  - если не поднимать свой docker-registry, то нужно чтобы на машине был доcтупен inet для скачивания образов
  (либо надо заранее стенд готовить)
  - нужно поднять сертификаты, чтобы работа шла по https
  - вообще должен работать dns
  - настроил vsftpd для создания /srv/ftp/pub/updates - для возможности выкладывать какие-то локальные обновления
  - в /etc/xinetd.conf скорректировать only_from (там по умолчанию 127.0.0.0 после установки)
  - /var/lib/docker перенесён в /srv/docker (bind в fstab) - "/srv" - это отдельный виртуальный диск со всякими данными

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


Подобные проекты
=================
https://docs.debops.org/en/master/
https://github.com/flant/dapp
https://github.com/travis-ci/dpl

----------------
Подготовка ВМ для создания vagrant box:

1) Добавить insecure pub key в /home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
2) очистить /etc/udevd/persistent...network
3) Удалить все сетевые карты кроме NAT
