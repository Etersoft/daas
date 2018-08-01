version: '2.2'

services:
  {{ node['node_name'] }}:
        build: 
           context: ./
           dockerfile: ./Dockerfile
        image: {{ node['image_name'] }}
        hostname: {{ node['hostname'] if 'hostname' in node and node['hostname']|length>0 else node['node_name'] }}
        tty: true
        {%- if 'cap_add' in node and node['cap_add']|length > 0 %}
        cap_add:
        {%- for v in node['cap_add'] %}
            - {{ v }}{% endfor %}
        {% endif %}
