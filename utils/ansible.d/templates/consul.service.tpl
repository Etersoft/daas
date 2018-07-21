[Unit]
Description=Consul service discovery agent
Documentation=https://consul.io/docs/
Requires=network-online.target
After=network.target

[Service]
User={{daas_vstand.consul.user}}
Group=consul
PIDFile=/var/lib/consul/consul.pid
Environment=CONSUL_PIDFILE=/var/lib/consul/consul.pid
Environment=CONSUL_CONFDIR=/etc/consul.d
EnvironmentFile=-/etc/sysconfig/consul
{% if daas_vstand.consul.extra_args != '' %}
Environment=CCONSUL_EXTRA_OPTIONS='{{daas_vstand.consul.extra_args}}'
{% endif %}

Restart=on-failure
+ExecStartPre=/usr/bin/env test -f "$CONSUL_PIDFILE" && /usr/bin/rm -f ${CONSUL_PIDFILE}
# ExecStartPre=/usr/local/bin/consul validate $CONFDIR
ExecStart=/usr/local/bin/consul agent $CONSUL_OPTIONS $CONSUL_EXTRA_OPTIONS -pid-file=${CONSUL_PIDFILE} -config-dir=${CONSUL_CONFDIR}
ExecReload=/bin/kill -s HUP $MAINPID
KillSignal=SIGINT
TimeoutStopSec=5

[Install]
WantedBy=multi-user.target
