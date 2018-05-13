{% if 'novnc_port' in node %}
upstream novnc-{{node['node_name']}} {
    server {{node['node_name']}}-novnc:{{node['novnc_port']}} fail_timeout=0;
}
{% endif %}
