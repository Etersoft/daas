{
  "description": "Dashboard for netdata",
  "editable": true,
  "gnetId": 1295,
  "graphTooltip": 0,
  "id": 3,
  "links": [],
  "panels": [
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 31,
      "panels": [],
      "repeat": null,
      "title": "CPU Utilization & Load Average",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "editable": true,
      "error": false,
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 1
      },
      "id": 1,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "softirq",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.cpu.softirq",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "user",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.cpu.user",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "system",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.cpu.system",
          "policy": "default",
          "refId": "D",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "iowait",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.cpu.iowait",
          "policy": "default",
          "refId": "E",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "CPU Utilization",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "percent",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "editable": true,
      "error": false,
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 1
      },
      "id": 2,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Load during the last minute",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.load.load1",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Load during the last 5 minutes",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.load.load5",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Load during the last 15 minutes",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.load.load15",
          "policy": "default",
          "refId": "D",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "Load Average",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 8
      },
      "id": 32,
      "panels": [],
      "repeat": null,
      "title": "Disk Space Usage & Disk Utilization",
      "type": "row"
    },
    {
      "alert": {
        "conditions": [
          {
            "evaluator": {
              "params": [
                5
              ],
              "type": "lt"
            },
            "operator": {
              "type": "and"
            },
            "query": {
              "datasourceId": 1,
              "model": {
                "alias": "Disk space available",
                "dsType": "influxdb",
                "groupBy": [
                  {
                    "params": [
                      "$interval"
                    ],
                    "type": "time"
                  },
                  {
                    "params": [
                      "null"
                    ],
                    "type": "fill"
                  }
                ],
                "measurement": "netdata.disk_space._.avail",
                "policy": "default",
                "refId": "B",
                "resultFormat": "time_series",
                "select": [
                  [
                    {
                      "params": [
                        "value"
                      ],
                      "type": "field"
                    },
                    {
                      "params": [],
                      "type": "mean"
                    }
                  ]
                ],
                "tags": [
                  {
                    "key": "host",
                    "operator": "=",
                    "value": "{{daas_vstand.hostname}}"
                  }
                ]
              },
              "params": [
                "B",
                "5m",
                "now"
              ]
            },
            "reducer": {
              "params": [],
              "type": "avg"
            },
            "type": "query"
          }
        ],
        "executionErrorState": "alerting",
        "frequency": "60s",
        "handler": 1,
        "name": "Disk Space Available ({{daas_vstand.hostname}})",
        "noDataState": "no_data",
        "notifications": []
      },
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "editable": true,
      "error": false,
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 9
      },
      "height": "250",
      "id": 3,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Disk space available",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk_space._.avail",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Disk space used",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk_space._.used",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Disk space reserved for root",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk_space._.reserved_for_root",
          "policy": "default",
          "refId": "D",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [
        {
          "colorMode": "critical",
          "fill": true,
          "line": true,
          "op": "lt",
          "value": 5
        }
      ],
      "timeFrom": null,
      "timeShift": null,
      "title": "Disk Space Usage",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "decgbytes",
          "label": "",
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "editable": true,
      "error": false,
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 9
      },
      "height": "250",
      "id": 14,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Utilization",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk_util.sda.utilization",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "Disk Utilization",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "percent",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 16
      },
      "id": 33,
      "panels": [],
      "repeat": null,
      "title": "Disk I/O Bandwidht & Disk Backlog",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 17
      },
      "id": 10,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Reads",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk.sda.reads",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Writes",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk.sda.writes",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "Disk I/O Bandwidth",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "KBs",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 17
      },
      "id": 16,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Backlog",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk_backlog.sda.backlog",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "Disk Backlog",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "ms",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 24
      },
      "id": 34,
      "panels": [],
      "repeat": null,
      "title": "Disk Completed I/O Operations & Disk Current I/O Operations",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 25
      },
      "id": 12,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Reads",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk_ops.sda.reads",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Writes",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk_ops.sda.writes",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "Disk Completed I/O Operations",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "iops",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 25
      },
      "id": 15,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Current operations",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.disk_qops.sda.operations",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "Disk Current I/O Operations",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "none",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 32
      },
      "id": 35,
      "panels": [],
      "repeat": null,
      "title": "System Memory & System Swap",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "editable": true,
      "error": false,
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 33
      },
      "id": 4,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Free ram",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.ram.free",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Used ram",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.ram.used",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Cached",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.ram.cached",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Buffers",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.ram.buffers",
          "policy": "default",
          "refId": "D",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "System Memory",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "decmbytes",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 33
      },
      "id": 5,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Free swap space",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.swap.free",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Used swap space",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.swap.used",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "System Swap",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "decmbytes",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": true,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 40
      },
      "id": 36,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 47
          },
          "id": 19,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Committed memory",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.committed.Committed_AS",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Committed Memory",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decmbytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        },
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 47
          },
          "id": 20,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Minor",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.pgfaults.minor",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Major",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.pgfaults.major",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Memory Page Faults",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "none",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        }
      ],
      "repeat": null,
      "title": "Committed Memory & Memory Page Faults",
      "type": "row"
    },
    {
      "collapsed": true,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 41
      },
      "id": 37,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 48
          },
          "id": 21,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Dirty",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.writeback.Dirty",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Writeback",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.writeback.Writeback",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Writeback Memory",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decmbytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        },
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 48
          },
          "id": 22,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Slab",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.kernel.Slab",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "KernelStack",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.kernel.KernelStack",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "PageTables",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.kernel.PageTables",
              "policy": "default",
              "refId": "C",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "VmallocUsed",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.kernel.VmallocUsed",
              "policy": "default",
              "refId": "D",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Memory Used by Kernel",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decmbytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        }
      ],
      "repeat": null,
      "title": "Writeback Memory & Memory Used by Kernel",
      "type": "row"
    },
    {
      "collapsed": true,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 42
      },
      "id": 38,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 49
          },
          "id": 23,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Shared",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.ksm.shared",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Unshared",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.ksm.unshared",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Sharing",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.ksm.sharing",
              "policy": "default",
              "refId": "C",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Volatile",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.ksm.volatile",
              "policy": "default",
              "refId": "D",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "To scan",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.ksm.to_scan",
              "policy": "default",
              "refId": "E",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Kernel Same Page Merging",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decmbytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        },
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 49
          },
          "id": 24,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Savings",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.ksm_savings.savings",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Offered",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.mem.ksm_savings.offered",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Kernel Same Page Merging Savings",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decmbytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        }
      ],
      "repeat": null,
      "title": "KSM & KSM Savings",
      "type": "row"
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 43
      },
      "id": 39,
      "panels": [],
      "repeat": null,
      "title": "System interrupts",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 24,
        "x": 0,
        "y": 44
      },
      "id": 6,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "NMI (non-maskable interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.NMI",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "LOC (local timer interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.LOC",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Total number of CPU interrupts",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.intr.interrupts",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "RES (rescheduling interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.RES",
          "policy": "default",
          "refId": "D",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "PMI (performance monitoring interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.PMI",
          "policy": "default",
          "refId": "E",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "CAL (function call interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.CAL",
          "policy": "default",
          "refId": "F",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "TLB (translation lookaside buffer shootdowns)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.TLB",
          "policy": "default",
          "refId": "G",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "MCP (machine check polls)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.MCP",
          "policy": "default",
          "refId": "H",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "TRM (thermal event interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.TRM",
          "policy": "default",
          "refId": "I",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "DFR (deferred error APIC interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.DFR",
          "policy": "default",
          "refId": "J",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "ERR (interrupts without known source)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.ERR",
          "policy": "default",
          "refId": "K",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "IWI (IRQ work interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.IWI",
          "policy": "default",
          "refId": "L",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "MCE (machine check exceptions)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.MCE",
          "policy": "default",
          "refId": "M",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "MIS (message signaled interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.MIS",
          "policy": "default",
          "refId": "N",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "PIN (posted-interrupt notification events)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.PIN",
          "policy": "default",
          "refId": "O",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "PIW (posted-interrupt wakeup events)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.PIW",
          "policy": "default",
          "refId": "P",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "RTR (APIC ICR read retries)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.RTR",
          "policy": "default",
          "refId": "Q",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "SPU (spurious interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.SPU",
          "policy": "default",
          "refId": "R",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "THR (threshold APIC interrupts)",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.interrupts.THR",
          "policy": "default",
          "refId": "S",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "System interrupts",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "none",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 51
      },
      "id": 40,
      "panels": [],
      "repeat": null,
      "title": "Total IPv4 Traffic & Total IPv6 Traffic",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "editable": true,
      "error": false,
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 52
      },
      "id": 7,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Received",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.ipv4.InOctets",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Sent",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.ipv4.OutOctets",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "Total IPv4 Traffic",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "Kbits",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 52
      },
      "id": 8,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Received",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.ipv6.received",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Sent",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.ipv6.sent",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "Total IPv6 Traffic",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "Kbits",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": true,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 59
      },
      "id": 41,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 66
          },
          "id": 25,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Received",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.ipv4.tcppackets.InSegs",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Sent",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.ipv4.tcppackets.OutSegs",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "IPv4 TCP Packets",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        },
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 66
          },
          "id": 26,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Received",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.ipv4.udppackets.InDatagrams",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Sent",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.ipv4.udppackets.OutDatagrams",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "IPv4 UDP Packets",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        }
      ],
      "repeat": null,
      "title": "IPv4 TCP/UDP Packets",
      "type": "row"
    },
    {
      "collapsed": true,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 60
      },
      "id": 42,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 67
          },
          "id": 27,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Received",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.ipv6.packets.received",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Sent",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.ipv6.packets.sent",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "IPv6 TCP Packets",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        },
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 67
          },
          "id": 28,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Received",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.ipv6.udppackets.received",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Sent",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.ipv6.udppackets.sent",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "IPv6 UDP Packets",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        }
      ],
      "repeat": null,
      "title": "IPv6 TCP/UDP Packets",
      "type": "row"
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 61
      },
      "id": 43,
      "panels": [],
      "repeat": null,
      "title": "System Processes & System Active Processes",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 62
      },
      "id": 9,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Running",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.processes.running",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Blocked",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.processes.blocked",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "System Processes (from /proc/stat)",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 62
      },
      "id": 11,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Active",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.active_processes.active",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "System Active Processes (from /proc/loadavg)",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 69
      },
      "id": 44,
      "panels": [],
      "repeat": null,
      "title": "System softirqs & System softnet",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 0,
        "y": 70
      },
      "id": 17,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "TIMER",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.TIMER",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "NET_TX",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.NET_TX",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "NET_RX",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.NET_RX",
          "policy": "default",
          "refId": "C",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "BLOCK",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.BLOCK",
          "policy": "default",
          "refId": "D",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "SCHED",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.SCHED",
          "policy": "default",
          "refId": "E",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "RCU",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.RCU",
          "policy": "default",
          "refId": "F",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "HI",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.HI",
          "policy": "default",
          "refId": "G",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "BLOCK_IOPOLL",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.BLOCK_IOPOLL",
          "policy": "default",
          "refId": "H",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "TASKLET",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.TASKLET",
          "policy": "default",
          "refId": "I",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "HRTIMER",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softirqs.HRTIMER",
          "policy": "default",
          "refId": "J",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "System softirqs",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "none",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "netdata",
      "editable": true,
      "error": false,
      "fill": 1,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 70
      },
      "id": 18,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "connected",
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "Processed",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softnet_stat.processed",
          "policy": "default",
          "refId": "A",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        },
        {
          "alias": "Dropped",
          "dsType": "influxdb",
          "groupBy": [
            {
              "params": [
                "$interval"
              ],
              "type": "time"
            },
            {
              "params": [
                "null"
              ],
              "type": "fill"
            }
          ],
          "measurement": "netdata.system.softnet_stat.dropped",
          "policy": "default",
          "refId": "B",
          "resultFormat": "time_series",
          "select": [
            [
              {
                "params": [
                  "value"
                ],
                "type": "field"
              },
              {
                "params": [],
                "type": "mean"
              }
            ]
          ],
          "tags": [
            {
              "key": "host",
              "operator": "=",
              "value": "{{daas_vstand.hostname}}"
            }
          ]
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeShift": null,
      "title": "System softnet",
      "tooltip": {
        "msResolution": false,
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": true,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 77
      },
      "id": 45,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 84
          },
          "id": 29,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Buffered",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.netdata.backend_metrics.buffered",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Sent",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.netdata.backend_metrics.sent",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Lost",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.netdata.backend_metrics.lost",
              "policy": "default",
              "refId": "C",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Netdata Backend Buffered Metrics",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "none",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        },
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "netdata",
          "fill": 1,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 84
          },
          "id": 30,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 1,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Buffered",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.netdata.backend_bytes.buffered",
              "policy": "default",
              "refId": "A",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Sent",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.netdata.backend_bytes.sent",
              "policy": "default",
              "refId": "B",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            },
            {
              "alias": "Lost",
              "dsType": "influxdb",
              "groupBy": [
                {
                  "params": [
                    "$interval"
                  ],
                  "type": "time"
                },
                {
                  "params": [
                    "null"
                  ],
                  "type": "fill"
                }
              ],
              "measurement": "netdata.netdata.backend_bytes.lost",
              "policy": "default",
              "refId": "C",
              "resultFormat": "time_series",
              "select": [
                [
                  {
                    "params": [
                      "value"
                    ],
                    "type": "field"
                  },
                  {
                    "params": [],
                    "type": "mean"
                  }
                ]
              ],
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "{{daas_vstand.hostname}}"
                }
              ]
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeShift": null,
          "title": "Netdata Backend Data Size",
          "tooltip": {
            "msResolution": false,
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "deckbytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ]
        }
      ],
      "repeat": null,
      "title": "Netdata Backend",
      "type": "row"
    }
  ],
  "refresh": false,
  "schemaVersion": 16,
  "style": "dark",
  "tags": [
    "{{daas_vstand.hostname}}-host"
  ],
  "templating": {
    "list": []
  },
  "time": {
    "from": "now-6h",
    "to": "now"
  },
  "timepicker": {
    "refresh_intervals": [
      "5s",
      "10s",
      "30s",
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "1d"
    ],
    "time_options": [
      "5m",
      "15m",
      "1h",
      "6h",
      "12h",
      "24h",
      "2d",
      "7d",
      "30d"
    ]
  },
  "timezone": "utc",
  "title": "netdata",
  "uid": "MGFgVy5iz",
  "version": 1
}