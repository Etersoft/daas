**DaaS** - "devops as a service" - это такой преднастроенный (но конфигурируемый если надо) набор сервисов,
позволяющих быстро организовать devops.

Задача
======
Создать преднастроенную систему взаимодествующих между собой сервисов для организации CI/CD
в небольшой по размеру команде разработчиков. Сервисы должны легко запускаться и конфигурироваться,
Легко мониториться, и по возможности легко переезжать на новое железо.
Должны быть предусмотрены backup-ы критичных данных и возможность быстрого восстановления.
Тестовые стенды под тот или иной проект должны разворачиваться "по нажатию одной кнопки",
должна быть предусмотрена возможность запустить столько тестовых стендов одного проекта,
сколько понадобится.

Архитектура
===========
Состав сервисов:
----------------
- Gitlab
- ВМ c docker (для развёртывания виртуальных тестовых стендов в замкнутой сети)
- ansible
- vagrant для управления Virtualbox-ами ( а может minukube? https://habr.com/company/flant/blog/333470/ )
- devops-api-server - REST API(единая точка входа для интерграции с jenkins, bugzilla, youtrack и т.п.)
- какая-то backup система
- мониторинг (grafana + netdata)
- service discovery (dns и не только) внутри ВМ (consul, registrator, consul-template)
- хранение приватной информации  (vault и/или локально ansible vault)

Концепция:
----------
Для того, чтобы обеспечить наличие независимой сети для каждого тестового стенда
(разные проекты могут иметь одинаковые ip), стенды запускаются внутри ВМ (virtualbox) с виртуальной сетью.
При этом чтобы обеспечить лёгкость запуска и сопровождения самих узлов используется docker. Поэтому
основная идея: docker запускается внутри ВМ, при этом тестовый стенд работает с виртуальной сетью внутри
ВМ (сеть наружу не выходит).
Имеется базовый преднастроенный образ ВМ тестового стенда. Для создания нового стенда под конкретный
проект используется ansible и vagrant, которые на основе базового образа ВМ преднастраивают сервисы и всё
необходимое для конкретного проекта. Gitlab является центральным элементом, вокруг которого строится процесс
(используются его механизмы CI/CD, issue, code review, MR  и.т.п.),

devops-api-server (*необходимость под вопросом*)
------------------
Это сервис с REST API, позволяющий единообразно общаться между разными сервисами.
Например запустить задачу в jenkins, поменять статус задачи или создать новую в youtrack, gitlab, bugzilla
и т.п. Его цель предоставить единый интерфейс к "разношёрстным" сервисам.
Т.к. многие продукты и так умеют работать между собой (gilab + jenkins, jenkins + youtrack),
то возможно этот слой "абстракции является лишним", с другой стороны если есть единый неизменный интерфейс
и все работают только через него, то изменения в API сторонних программ (gitlab, jenkins, youtrack и т.п.)
не будут затрагивать работу, т.к. будет корректироваться только реализация общения с конкретным
изменившимся API. Минусом зато является поддержка всего этого.

Документация
------------
* [Общее описание конфигурационного файла](docs/config.md)
* [Шаблоны](docs/templates.md)
* [Addons](docs/addons.md)
* [Настройка сети](docs/network.md)
* [Установка пакетов](docs/apt.md)
* [Подключение каталогов](docs/volumes.md)
* [Доступ к узлам по ssh](docs/ssh.md)
* [Унифицированный доступ к узлам через web-интерфейс (nginx)](docs/nginx.md)
* [Доступ к графическому интерфейсу через браузер (novnc)](docs/novnc.md)
* [Доступ к логам процессов на узлах](docs/logdb.md)
* [Работа с gitlab](docs/gitlab.md)
* [Работа с docker image](docs/image.md)
* Администрирование стендов
 * [Управление виртуальными стендами](docs/admin.md)
