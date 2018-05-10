# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install nginx \
	&& apt-get clean \
	&& rm -rf /usr/share/doc/* \
	&& rm -rf /usr/share/man/* \
	&& rm -rf /etc/apt/sources.list.d/* \
	&& apt-get update

COPY run-nginx.sh /usr/local/bin/
COPY *nginx.conf /etc/nginx/sites-enabled.d/

RUN mkdir -p /etc/nginx/vnc.d/
COPY vnc.d/* /etc/nginx/vnc.d/

RUN mkdir -p /etc/nginx/logdb.d/
COPY logdb.d/* /etc/nginx/logdb.d/

CMD ["run-nginx.sh"]
