version: '2'

services:
  {{ node['node_name'] }}:
        build: 
           context: ./
           dockerfile: ./Dockerfile
        image: {{ node['image_name'] }}
        hostname: {{ node['node_name'] }}
        tty: true
