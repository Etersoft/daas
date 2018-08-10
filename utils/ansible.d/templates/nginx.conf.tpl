allow 0.0.0.0/24;
#deny  all;

include services.d/*-upstream.conf;

# default server
server {
	listen  *:80 default_server;
	server_name localhost.localdomain localhost;

	include services.d/*-location.conf;
}