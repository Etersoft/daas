version: '2.2'

services:
    {%- for node in project['nodes'] if not 'skip_compose' in node %}
    {{ node['node_name'] }}:
        build: 
           context: ./{{ node['context'] }}
           dockerfile: Dockerfile
        image: {{ node['image_name'] }}
        hostname: {{ node['hostname'] if 'hostname' in node and node['hostname']|length>0 else node['node_name'] }}
        {%- if 'start_command' in node and node['start_command'] != None %}
        command: {{ node['start_command'] }}
        {%- endif %}
        networks:
            {{ project['net_name'] }}:
        {%- for net in project['sorted_networks'] %}
	    {%- if node[net['name']] %}
            {{net['name']}}: { ipv4_address: {{ node[net['name']] }} }
            {%- else %}
            {{net['name']}}:
            {%- endif -%}
        {%- endfor -%}
        {%- if 'ports' in node and node['ports']|length > 0 %}
        ports:
        {%- if 'ssh_port' in node %}
            - "{{ node['ssh_port'] }}:{{ node['ssh_internal_port'] }}"
        {%- endif %}
        {%- for p in node['ports'] %}
            - "{{ p }}"{% endfor %}
        {%- endif %}
        {%- if 'cap_add' in node and node['cap_add']|length > 0 %}
        cap_add:
        {%- for v in node['cap_add'] %}
            - {{ v }}{% endfor %}
        {%- endif %}
        {%- if 'volumes' in node and node['volumes']|length > 0 %}
        volumes:
        {%- for v in node['volumes'] %}
            - {{ v }}{% endfor %}
        {%- endif %}
        {% if 'devices' in node and node['devices']|length > 0 %}
        devices:
        {%- for v in node['devices'] %}
            - {{ v }}{% endfor %}
        {%- endif %}
        {%- if 'environment' in node and node['environment']|length > 0 %}
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
        {% if 'extra_hosts' in project and project['extra_hosts']|length > 0 %}
        extra_hosts:
        {%- for host in project['extra_hosts'] %}
                - "{{ host['node_name'] }}: {{ host['ip'] }}"{% endfor %}
        {%- endif %}
        {%- endfor %}

    # noVNC services
    {%- for node in project['nodes'] if not 'skip_compose' in node and 'novnc_port' in node %}
    {{ node['node_name'] }}-novnc:
        build: 
           context: ./{{ node['node_name'] }}
           dockerfile: Dockerfile.novnc
        image: {{ project['name'] }}-novnc
        hostname: novnc-{{ node['node_name'] }}
        networks:
            - {{ project['net_name'] }}
        environment:
             VNC_RUN_PARAMS: "--vnc {{ node['node_name'] }}:{{ node['vnc_port'] }} --listen {{ node['novnc_port'] }}"
        ports:
            - "{{ node['novnc_port'] }}:{{ node['novnc_port'] }}"
    {%- endfor %}
    
    {%- if project['required_nginx'] %}
    nginx:
        build: 
           context: ./nginx
           dockerfile: Dockerfile
        image: {{ project['name'] }}-nginx
        hostname: nginx
        ports:
            - "{{ project['nginx']['port'] }}:{{ project['nginx']['internal_port'] }}"
        tty: true
        networks:
            - {{ project['net_name'] }}
    {%- endif %}
    
    {%- if project['required_logdb'] and not 'skip_compose' in project['logdb'] %}
    logdb:
        build: 
           context: ./logdb
           dockerfile: Dockerfile
        image: {{ project['name'] }}-logdb
        hostname: logdb
        tty: true
        ports:
            - "{{ project['logdb']['port'] }}:{{ project['logdb']['port'] }}"
        {% if 'db_disable' not in project['logdb'] %}
        volumes:
            - ./logdb/logdb:/var/logdb
        {%- endif %}
        environment:
            {%- if 'debug' in project['logdb'] and project['logdb']['debug'].lower() != 'none' %}
            - LOGDB_LOG="{{ project['logdb']['debug'] }}"
            {%- endif %}
            {%- if 'db_disable' in project['logdb'] %}
            - LOGDB_DB_DISABLE=--logdb-db-disable
            {%- endif %}
            - LOGDB_HOST=0.0.0.0
            - LOGDB_PORT={{ project['logdb']['port'] }}
            - LOGDB_EXTPARAMS=--logdb-httpserver-reply-addr {{ project['stand_hostname'] }}
        networks:
            {{ project['net_name'] }}:
        {%- for net in project['sorted_networks'] %}
	    {%- if project['logdb'][net['name']] %}
            {{net['name']}}: { ipv4_address: {{ project['logdb'][net['name']] }} }
            {%- else %}
            {{net['name']}}:
            {%- endif %}
        {%- endfor %}
        {% if 'extra_hosts' in project and project['extra_hosts']|length > 0 %}
        extra_hosts:
        {%- for host in project['extra_hosts'] %}
                - "{{ host['node_name'] }}: {{ host['ip'] }}"
        {%- endfor %}
        {%- endif %}
    {%- endif %}
        
networks:
    {{ project['net_name'] }}:
        driver: bridge
        driver_opts:
            com.docker.network.enable_ipv6: "false"
        ipam:
            driver: default

    {%- for net in project['sorted_networks'] %}
    {{net['name']}}:
        driver: bridge
        driver_opts:
            com.docker.network.enable_ipv6: "false"
        ipam:
            driver: default
            {%- if net['subnet'] %}
            config:
                - subnet: {{ net['subnet'] }}.0/24
                  {%- if 'gateway' in net %}
                  gateway: {{ net['subnet'] }}.{{ net['gateway'] }}
                  {%- endif %}
            {% endif %}
   {% endfor %}       
