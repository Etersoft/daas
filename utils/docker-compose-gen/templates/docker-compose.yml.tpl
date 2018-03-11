version: '2'

services:
    {% for node in project['nodes'] %}
    {{ node['nodename'] }}:
        build: 
           context: ./{{ node['nodename'] }}
           dockerfile: Dockerfile
        image: {{ project['name'] }}-{{ node['image'] }}
        hostname: {{ node['nodename'] }}
        networks: 
            {% for net in project['sorted_networks'] %}
            {{net['name']}}:
                ipv4_address: {{ node[net['name']] }}{% endfor %}
                
        command: /usr/bin/start-project.sh
        tty: true
        extra_hosts:
             {% for host in project['extra_hosts'] %}
                - "{{ host['nodename'] }}: {{ host['ip'] }}"{% endfor %}
    {% endfor %}       

networks:
   {% for net in project['sorted_networks'] %}
    {{net['name']}}:
        driver: bridge
        driver_opts:
            com.docker.network.enable_ipv6: "false"
        ipam:
            driver: default
            config:
                - subnet: {{ net['subnet'] }}.0/24
                  gateway: {{ net['subnet'] }}.{{ project['builder']['ip'] }}
   {% endfor %}       
