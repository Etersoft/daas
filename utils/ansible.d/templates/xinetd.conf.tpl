#
# Simple configuration file for xinetd
#
# Some defaults, and include /etc/xinetd.d/

defaults
{
	log_type = SYSLOG authpriv info
	log_on_success = PID HOST DURATION
	log_on_failure = HOST
	instances = 100
	per_source = 5
	only_from = 0.0.0.0
}

includedir /etc/xinetd.d
