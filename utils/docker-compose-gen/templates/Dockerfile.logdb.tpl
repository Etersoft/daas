# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install libuniset2-extension-logdb uniset2-utils \
	&& apt-get clean \
	&& rm -rf /usr/share/doc/* \
	&& rm -rf /usr/share/man/* \
	&& rm -rf /etc/apt/sources.list.d/* \
	&& apt-get update

COPY run-logdb.sh /usr/local/bin/
RUN mkdir -p /etc/logdb
COPY {{ project['name'] }}-logdb-conf.xml /etc/logdb/logdb-conf.xml

CMD ["run-logdb.sh"]
