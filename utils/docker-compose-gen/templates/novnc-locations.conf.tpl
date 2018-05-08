{% if 'novnc_port' in node %}
  location /sock-{{node['node_name']}} {
          proxy_http_version 1.1;
          proxy_pass http://novnc-{{node['node_name']}};
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";

          # VNC connection timeout
          proxy_read_timeout 61s;

          # Disable cache
          proxy_buffering off;
    }

    location ~ ^/vnc/{{node['node_name']}}[/]*$ {
        return 301 http://$server_name/vnc/{{node['node_name']}}/vnc_auto.html?host={{project['stand_hostname']}}&port={{node['novnc_port']}}&path=sock-{{node['node_name']}};
    }

    location /vnc/{{node['node_name']}} {
        rewrite ^/vnc/{{node['node_name']}}/(.*)$ /$1 break;
        index vnc_auto.html;
        proxy_pass http://novnc-{{node['node_name']}}/;
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
{% endif %}
