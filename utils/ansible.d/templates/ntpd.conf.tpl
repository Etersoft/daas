{%- for server in daas_vstand.ntpd.servers %}
server {{server}}
{% endfor -%}
