# Мониторинг работы стенда

Для мониторинга сервисом и параметров работы стенда, на стенде разворачиваются следующие компоненты:

* [netdata](https://github.com/firehol/netdata/wiki) - для мониторинга в реальном времени
* [grafana](https://grafana.com/) - для просмотра данных на длительном временном интервале

Для доступа к этим системам, запускается *nginx*
* ```http://hostname/netdata``` - доступ к netdata
* ```http://hostname/grafana``` - доступ к grafana

В качестве источника данных для графана выступает *influxdb*, в которую
*netdata* пишет данные.