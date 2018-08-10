# netdata configuration
#
# You can download the latest version of this file, using:
#
#  wget -O /etc/netdata/netdata.conf http://localhost:19999/netdata.conf
# or
#  curl -o /etc/netdata/netdata.conf http://localhost:19999/netdata.conf
#
# You can uncomment and change any of the options below.
# The value shown in the commented settings, is the default value.
#

[global]
    run as user = netdata

    # the default database size - 1 hour
    history = 3600

    # by default do not expose the netdata port
    bind to = 0.0.0.0

[web]
    web files owner = root
    web files group = netdata

[backend]
    enabled = yes
    type = opentsdb
    host tags = host={{daas_vstand.hostname}}
    destination = localhost:4242
    data source = average
    prefix = netdata
    hostname = {{daas_vstand.hostname}}
    update every = 10
    buffer on failures = 10
    timeout ms = 20000
        send charts matching = *
        send hosts matching = localhost *
        send names instead of ids = yes
