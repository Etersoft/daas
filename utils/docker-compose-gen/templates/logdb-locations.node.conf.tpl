{%- for node in project['nodes'] if 'logservers' in node and node['logservers']|length > 0 %}
    location /logdb/{{ node['node_name'] }} {
        #rewrite ^/logdb/(.*)$ /logdb/$1 break;
        proxy_redirect off;
        proxy_set_header Accept-Encoding "";
        proxy_pass http://logdb-{{ node['node_name'] }}/logdb/;
        sub_filter_once off;
        sub_filter_types *;
        sub_filter 'logdb/ws' 'logdb/{{ node['node_name'] }}/ws';

        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header x-forwarded-proto https;
        proxy_set_header Host $host;
        proxy_http_version 1.1;
        proxy_read_timeout 15s;

       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection "upgrade";
    }
{% endfor %}
