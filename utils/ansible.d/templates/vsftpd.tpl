# default: off
# description: The vsftpd FTP server.
service ftp
{
	disable		= no
	socket_type	= stream
	protocol	= tcp
	wait		= no  
	user		= root
	nice		= 10
	rlimit_as	= 200M
	server		= /usr/sbin/vsftpd
#	server_args	= 
#   access_times = 2:00-9:00 12:00-24:00 # время, когда возможен доступ
}
