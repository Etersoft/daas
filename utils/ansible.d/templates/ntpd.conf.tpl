{%- for server in vstand.ntpd.servers %}
server {{server}}
{% endfor -%}
