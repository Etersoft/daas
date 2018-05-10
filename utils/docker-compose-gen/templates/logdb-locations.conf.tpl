    location /logdb/ {
        #rewrite ^/logdb/(.*)$ /logdb/$1 break;
        proxy_redirect off;
        proxy_pass http://logdb-{{ project['name'] }}/logdb/;
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
