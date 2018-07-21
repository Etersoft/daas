{
    {% if daas_vstand.consul.mode == 'server' %}
    "server": true,
    {% endif %}
{% if daas_vstand.consul.bind != '' %}
    "bind_addr": {% raw %}"{{GetInterfaceIP \"eth1\"}}"{% endraw %},
{% else %}
    "bind_addr": {% raw %}"{{GetPrivateIP}}"{% endraw %},
{% endif %}
    "client_addr": "0.0.0.0"
    , "data_dir": "/var/lib/consul"
    ,"datacenter": "{{daas_vstand.consul.dc}}"
    , "log_level": "{{daas_vstand.consul.log_level}}"
    , "leave_on_terminate": true
    {% if daas_vstand.consul.dns_servers|length > 0 -%}
    , "recursors" : [
    {% for dns in daas_vstand.consul.dns_servers %}
    "{{dns}}"{{ "," if not loop.last else '' }}
    {% endfor -%}
    ]
    {% endif %}
    {% if daas_vstand.consul.servers|length > 0 -%}
    , "retry_join": [
    {% for srv in daas_vstand.consul.servers %}
     "{{srv}}"{{ "," if not loop.last else '' }}
    {% endfor -%}
    ]
    , "start_join": [
    {% for srv in daas_vstand.consul.servers %}
     "{{srv}}"{{ "," if not loop.last else '' }}
    {% endfor -%}
    ]
    {% endif %}
}