#!/bin/sh -x

update_chrooted conf

[ -z "$LOGDB_DB_DISABLE" ] && uniset2-logdb-adm create /var/logdb/logdb.db

[ -z "$LOGDB_LOG" ] && LOGDB_LOG='none'
[ -z "$LOGDB_HOST" ] && LOGDB_HOST=localhost
[ -z "$LOGDB_PORT" ] && LOGDB_HOST=9080
[ -z "$LOGDB_EXTPARAMS" ] && LOGDB_EXTPARAMS=''
[ -z "$LOGDB_CONFILE" ] && LOGDB_CONFILE='/etc/logdb/logdb-conf.xml'

uniset2-logdb --logdb-single-confile ${LOGDB_CONFILE} \
	--logdb-dbfile /var/logdb/logdb.db \
	--logdb-httpserver-host $LOGDB_HOST \
	--logdb-httpserver-port $LOGDB_PORT \
	--logdb-log-add-levels $LOGDB_LOG \
	$LOGDB_DB_DISABLE $LOGDB_EXTPARAMS
