{% if 'novnc_port' in node %}
upstream novnc-{{node['node_name']}} {
    server 127.0.0.1:{{node['novnc_port']}} fail_timeout=0;
}
{% endif %}
