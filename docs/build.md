### Сборка проекта в docker
Для сборки своего проекта в docker при помощи daas необходимо сделать следующие шаги

#### Создать файл проекта `.daas.yml` прописав в него необходимые параметры и зависимости.
В общем случае можно объявить несколько сборщиков (секция `nodes`), для разных платформ. 
В каждом сборщике прописывается базовый `image` - шаблон определяющий контейнер где будет собираться проект.
Так же можно добавить `sources` для установки необходимых пакетов и прописать зависимости 
которые необходимо установить `apt/packages`.


Пример:

```
version: 0.3

project:
  name: "myproject"

  # Project
  groups:
    builders:
      nodes:
        builder1:
          skip_compose: yes
          image: x64.sisyphus-builder
          apt:
            sources:
              - "rpm http://ftp.altlinux.org/pub/distributions ALTLinux/Sisyphus/x86_64 classic"
              - "rpm http://ftp.altlinux.org/pub/distributions ALTLinux/Sisyphus/noarch classic"
              - "rpm http://ftp.etersoft.ru/pub/Etersoft/LINUX@Etersoft/Sisyphus x86_64 addon"
              - "rpm http://ftp.etersoft.ru/pub/Etersoft/LINUX@Etersoft/Sisyphus noarch addon"  
            packages:
              - rpm-build-intro
              - boost-asio-devel 
              - boost-filesystem-devel 
              - boost-intrusive-devel 
              - boost-program_options-devel 
              - boost-signals-devel 
              - boost-interprocess-devel
              - ccmake 
              - glib2-devel
              - libfcgi-devel
```

#### Вторым шагом запускается команда сборки
Для этого в каталоге с исходниками проекта и лежащим тут же файлом `.daas.yml`
запускается команда:

* `daas rpmbuild builder1`

где `builder` это название конкретного образа где будет производиться сборка (из списка `nodes`).

Дополнительные параметры сборки можно посмотреть командой:
```daas rpmbuild help```
