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
            net1:
                ipv4_address: {{ node['ip1'] }}
            net2:
                ipv4_address: {{ node['ip2'] }}
            
        command: /usr/bin/start-project.sh
        tty: true
        extra_hosts:
             {% for host in project['extra_hosts'] %}
                - "{{ host['nodename'] }}: {{ host['ip'] }}"{% endfor %}
    {% endfor %}       

networks:
    net1:
        driver: bridge
        driver_opts:
            com.docker.network.enable_ipv6: "false"
        ipam:
            driver: default
            config:
                - subnet: {{ project['subnet1'] }}.0/24
                  gateway: {{ project['subnet1'] }}.{{ project['builder']['ip1']}}
    net2:
        driver: bridge
        driver_opts:
            com.docker.network.enable_ipv6: "false"
        ipam:
            driver: default
            config:
                - subnet: {{ project['subnet2'] }}.0/24
                  gateway: {{ project['subnet2'] }}.{{ project['builder']['ip2']}}

