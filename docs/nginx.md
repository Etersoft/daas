Общее описание сервсиса nginx
------------------------------
Для web-доступа к различным сервисам запускаемым внутри стенда, предусмотрен
запуск специального контейнера nginx.
В его задачи входит предоставление web-доступа к внутренним службам виртуального стенда.

При своём запуске он занимает 80-ый порт и работает как прокси для внутренних сервисов.
Работа ведётся по адресу: http://stand-hostname/...

На текущий момент доступны следующие сервисы

* http://stand-hostname/logdb/ws         - сервис просмотра логов во время тестирования (см. [logdb](docs/logdb.md))
* http://stand-hostname/vnc/_node_name_  - доступ к графике (vnc) на узле _node_name_  (см. [novnc](docs/novnc.md))

Настройка сервиса nginx
========================
Настройки для сервиса nginx находятся в глобальной секции настроек файла проекта.
Эта секция не является обязательной.

```yaml
nginx:
  apt:
    packages:
      - mc
      - curl
    sources:
      - "rpm http://my-updates/pub x86_64 my"
      
  any:
    - myconf.location
    - myconf.upstream
```

Если есть необходимость доустановить пакеты или 
установить более новые пакеты в этот контейнер, то для этого предусмотрен раздел [apt](docs/apt.md)

Секция *any* позволяет добавлять в nginx свои конфигурационные файлы. В итоге они попадают в каталог
**/etc/nginx/any.d/**

При этом *nginx.conf* файле настройки разделяются на upstream-файлы и location-файлы.

```
...
include any.d/*-upstream.conf;

# default server
server {
	listen  *:80 default_server;
	...
	
	# any
	include any.d/*-location.conf;
}	
```

Сами файлы должны находиться в каталоге [addons](docs/addons.md), оттуда они будут копироваться при сборке контейнера nginx

Пример my-location.conf

```
    location /weblog/ {
        proxy_redirect off;
        proxy_pass http://weblog-backend/;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header x-forwarded-proto https;
        proxy_set_header Host $host;
        proxy_http_version 1.1;
        proxy_read_timeout 15s;

       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection "upgrade";
    }
```

Пример my-upstream.conf

```
    upstream weblog-backend {
         server my-backend:8080 fail_timeout=0;
    }
```