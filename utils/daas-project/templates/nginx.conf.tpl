allow 0.0.0.0/24;
#deny  all;

include vnc.d/*-upstream.conf;
include logdb.d/*-upstream.conf;

# default server
server {
	listen  *:80 default_server;
	server_name {{project['stand_hostname']}} localhost;

	# vnc
	include vnc.d/*-locations.conf;
	
	# logdb
	include logdb.d/*-locations.conf;
}
