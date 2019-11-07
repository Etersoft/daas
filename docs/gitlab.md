Работа с gitlab
---------------
Модуль gitlab предназначен для взаимодействия с gitlab.

Вызов модуля стандартный:
```daas gitlab xxx```

Где xxx - это какая-то команда.

Доступны следующие команды:
```bash
# daas gitlab help
gitlab [command] [params]
Command: 
get BUILD_NUM [CFG_SECTION] [CFG_FILE] - load artifacts from build #BUILD_NUM
                                         CFG_SECTION - section in cfg-file. By default used [global] default = ..
                                         About the config file format, read 
                                         https://python-gitlab.readthedocs.io/en/stable/cli.html
```

Скачивание артефактов (get)
---------------------------
Получить архив с артефактами сборки можно командой

```daas gitlab get BUILD_NUM```

Где BUILD_NUM - номер задания(job) в gitlab.
При этом в текущем каталоге будет сохранён архив с именем **BUILDNUM_artifacts.zip**.

Для того, чтобы эта команда работала, необходимо существование конфигурационного файла.
По умолчанию он должен лежать в домашнем каталоге пользователя и называться **.python-gitlab.cfg**.
Это сделано для совместимости со штатным консольным cli (python) интерфейсом для gitlab.
Формат этого файла описан здесь https://python-gitlab.readthedocs.io/en/stable/cli.html

Пример:
```
[global]
default = myproject
ssl_verify = true
timeout = 5

[myproject]
url = https://mygitlab.host.ru
private_token = z2acsd3fdvdfvfd_sadfk
api_version = 4
project_namespace = ASU/myproject
```

Если команде **get** не указана конкретная настроечная секция **"[xxx]"** то будет использована 
секция указанная в *[global]*.
Если необходимо использовать другой конфигурационный файл, то это можно указать "третьим" параметром.

