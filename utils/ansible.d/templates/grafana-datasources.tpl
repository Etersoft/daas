apiVersion: 1

datasources:
- name: netdata
  type: influxdb
  access: proxy
  orgId: 1
  url: http://localhost:8086
  database: opentsdb
