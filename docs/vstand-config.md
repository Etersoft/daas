# Описание формата настроечного файла для стенда

**ВАЖНО!:** Раздел описывающий параметры виртуального стенда должен называться **vstand**.
Полная версия параметров представлена ниже:

```yaml
---
vstand:
 
  # Параметры доступа к host-машине
  hostmachine:
     hostname: "vstand"
     user: "vagrant"
     pass: "vagrant"
     pub_interface: ''

  # Параметры относящиеся к виртуальному стенду
  hostname: "vstand-{{project.name}}"
  user: "vadmin"
  pass: "vadmin"

  apt:
    sources:
      - "rpm http://ftp.etersoft.ru/pub ALTLinux/p8/branch/x86_64 classic"
      - "rpm http://ftp.etersoft.ru/pub ALTLinux/p8/branch/noarch classic" 
      - "rpm http://ftp.etersoft.ru/pub/Etersoft/LINUX@Etersoft/p8 branch/x86_64 addon"
      - "rpm http://ftp.etersoft.ru/pub/Etersoft/LINUX@Etersoft/p8 branch/noarch addon"
    packages:
      - mc

  limits:
     cpu: 3
     memory: 2048

  # Версия vagrant и используемый box файл
  vagrant:
     rpm_url: "{{ daas_data_dir }}/vstand/vagrant/distrib/p8/vagrant.rpm"
     patch: "{{ daas_data_dir }}/vstand/vagrant/distrib/p8/network_fix_ipv6.rb.patch"
     box: 
       name: "vstand-p8"
       url: "vpavel/vstand-altlinux-p8"

  # Параметры работы с gitlab
  gitlab:
     url: "http://gitlab.organization.ru"
     runner_registration_token: 'Unknown gitlab runner registration token'
     runner_download_url: "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64"
     runners:
       - runner:
             description: "shell runner for {{project.name}}"
             tags: "build, {{project.name}}-vstand-runner"
             executor: "shell"
             
       - runner: 
             description: "docker runner for {{project.name}}"
             tags: "docker-build, {{project.name}}-vstand-docker-runner"
             executor: "docker"
             docker_image: 'fotengauer/altlinux-p8'
             extra_options: '--docker-cap-add ALL --docker-volumes /var/run/docker.sock:/var/run/docker.sock --docker-privileged'

  # Версия daas устанавливаемая на стенд
  daas_url: "{{daas_ansible_dir}}/addons/daas-0.3-alt3.noarch.rpm"
       
  # Список серверов для синхронзации времени на стенде
  ntpd:
     servers:
       - "0.ru.pool.ntp.org"
       - "1.ru.pool.ntp.org"
```

### Параметры доступа к host машине (hostmachine)
Раздел **hostmachine** описывает параметры доступа к host-машине, на которой будут
разворачиваться виртуальные стенды под проекты.
* **user**    - пользователь, с правами установки пакетов и настройки
* **pass**    - пароль (будет использован если не срабатывает доступ по ключу)
* **hostname** - название которое будет выставлено host машине после его подготовки. Не обязательный параметр.
* **pub_interface** - Параметр задающий публичный интерфейс на host-машине в который будет проброшен (сетевой мост)
сетевой интерфейс виртуального стенда для доступа внешни сервисам, таким как gitlab, интернет и т.п.
Его необходимо задавать если на host-машине несколько сетевых интерфейсов и не работает сеть в создаваемых
виртуальных машинах.

### Параметры доуступа к виртуальным стендам
* **user**     - пользователь, под которым будет вестить вся работа на виртуальном стенде, в том числе gitlab-runner запускаются под ним.
* **pass**     - пароль для пользователя *user*
* **hostname** - название которое будет выставлено при создании нового виртуального стенда. Может содержать {{project-name}} и т.п.
* **ip**       - статический ip для виртуального стенда в виде **xxx.xxx.xxx.xxx/netmask**. По умолчанию используется *dhcp*.

### Настройки apt для виртуальных стендов
Раздел **apt** позволяет задать дополнительныйс список репозиториев **sources** и список пакетов устанавливаемых 
на виртуальный стенд во время его создания.

### Лимиты для виртуальных серверов (limits)
Раздел **limits** позволяет задать лимиты для каждого создаваемого виртуального сервера.
* **cpu**     - количество используемых CPU
* **memory**  - используемая память (MB).

### Настройки vagrant
Раздел **vagrant** позволяет более точно указать версию vagrant устанавливаемую на стенд, а так же используемый
для виртуальных стендов box-образ.
* **rpm_url**   - путь где взять пакет с vagrant. Может содержать url вида (ftp, http, и т.п.) для скачивания по сети. Либо локальное имя файла.
* **patch**     - указание патча накладываемого после установки vagrant в случае необходимости. Например отключающего использование ipv6.
* **box.name**  - имя box-а которое будет использовано при развертывании стендов
* **box.url**   - url для скачивания box-файла. Может содержать url вида http,ftp и т.п. для скачивания, либо локальное имя файла.

### Настройки gitlab
Раздел **gitlab** задаёт параметры работы с gitlab

* **url**                       - адрес используемого gitlab сервера.
* **runner_registration_token** - токен для регистрации runner-ов (берётся из настроек gitlab)

Подраздел **runners** описывает runner-ы которые будут зарегистрированы при создании виртуального стенда.

**ВАЖНО:** параметры каждого runner-а должны описываться в подразделе с названием **runner**.

* **description**   - *уникальное* описание данного runner-а
* **tags**          - теги задач на которые он реагирует 
* **executor**      - тип runner-а
* **docker_image**  - указание образа для executor типа "docker"
* **extra_options** - дополнительные парамеры передаваемые команде gitlab-runner register (см. ```gitlab-runner register --help```) 

Что такое gitlab-runner, их виды и другую информацию можно посмотреть [здесь](https://docs.gitlab.com/runner/)

### Настройки daas
По умолчанию на виртуальный стенд просто ставиться daas из репозиториев. Но параметр **daas_url** позволяет
указать конкретный rpm пакет который должен быть установлен. Это может быть локальный файл или url для скачивания.

### Синхронизация времени (nptd)
Для синхронзации времении на разворачиваемых виртуальных стендах используется *ntpd*. Раздел **servers**
позволяет задать список серверов для синхронизации.

