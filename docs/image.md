Вспомогательный модуль для работы с docker image.

Этот модуль является вспомогательным и содержит в себе некоторые helper-команды
для работы с образами. Вызывается командой
``` daas image [command] ```

```bash

# daas image -h
image [command] [params]
Command: 
ls                                          - list images
old N ['days'|'hours'|'months'|'years']     - list of images older than N ['days']. Default: 'days'
rm N ['days'|'hours'|'months'|'years'] [-f] - remove images older than N ['days']. Default: 'days'
                                              -f - force remove
```

* *ls* - просто вывести список доступных образов. Повторяет команду ```docker image ls```
* *old* - позволяет вывести список образов старее *N* дней(часов, месяцев,лет).
* *rm* - позволяет удалить образы старее *N* дней(часов, месяцев,лет).
