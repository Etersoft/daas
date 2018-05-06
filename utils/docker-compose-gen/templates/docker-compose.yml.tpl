version: '2'

services:
    {%- for node in project['nodes'] if not 'skip_compose' in node %}
    {{ node['node_name'] }}:
        build: 
           context: ./{{ node['node_name'] }}
           dockerfile: Dockerfile
        image: {{ node['image_name'] }}
        hostname: {{ node['node_name'] }}
        {%- if 'start_command' in node %}
        command: {{ node['start_command'] }}
        {%- endif %}
        networks:{% for net in project['sorted_networks'] %}
            {{net['name']}}:
                ipv4_address: {{ node[net['name']] }}{% endfor %}
        {%- if 'ports' in node and node['ports']|length > 0 %}
        ports:
        {%- for p in node['ports'] %}
            - {{ p }}{% endfor %}
        {%- endif %}
        {% if 'volumes' in node and node['volumes']|length > 0 %}
        volumes:
        {%- for v in node['volumes'] %}
            - {{ v }}{% endfor %}
        {%- endif %}
        {% if 'devices' in node and node['devices']|length > 0 %}
        devices:
        {%- for v in node['devices'] %}
            - {{ v }}{% endfor %}
        {%- endif %}
        {%- if 'environment' in node and node['environmen']|length > 0 %}
        environment:
        {%- for v in node['environment'] %}
            - {{ v }}{% endfor %}
        {%- endif %}
        {% if 'env_file' in node and node['env_file']|length > 0 %}
        env_file:
        {%- for v in node['env_file'] %}
            - {{ v }}{% endfor %}
        {%- endif %}
        tty: true
        extra_hosts:
        {%- for host in project['extra_hosts'] %}
                - "{{ host['node_name'] }}: {{ host['ip'] }}"{% endfor %}
        {%- endfor %}       

networks:
   {%- for net in project['sorted_networks'] %}
    {{net['name']}}:
        driver: bridge
        driver_opts:
            com.docker.network.enable_ipv6: "false"
        ipam:
            driver: default
            config:
                - subnet: {{ net['subnet'] }}.0/24
                  {%- if 'gateway' in net %}
                  gateway: {{ net['subnet'] }}.{{ net['gateway'] }}
                  {%- endif %}
   {% endfor %}       
