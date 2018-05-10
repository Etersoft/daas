<?xml version="1.0" encoding="utf-8"?>
<LogDB name="LogDB">
{%- for node in project['nodes'] if 'logservers' in node and node['logservers']|length > 0 %}
{%- for log in node['logservers'] %}
    <logserver name="{{ log['name'] }}" ip="{{ node['node_name'] }}" port="{{ log['port'] }}" cmd="{{ log['cmd'] }}" description="{{ log['description'] }}"/>
{%- endfor %}
{%- endfor %}
</LogDB>
