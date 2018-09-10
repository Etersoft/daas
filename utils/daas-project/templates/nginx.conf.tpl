allow 0.0.0.0/24;
#deny  all;

include vnc.d/*-upstream.conf;
include logdb.d/*-upstream.conf;
include any.d/*-upstream.conf;

# default server
server {
	listen  *:{{ project['nginx']['internal_port'] }} default_server;
	server_name {{project['stand_hostname']}} localhost;

	# vnc
	include vnc.d/*-location.conf;
	
	# logdb
	include logdb.d/*-location.conf;

	# any
	include any.d/*-location.conf;
}
