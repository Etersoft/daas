# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install novnc \
	&& apt-get clean \
	&& rm -rf /usr/share/doc/* \
	&& rm -rf /usr/share/man/* \
	&& rm -rf /etc/apt/sources.list.d/* \
	&& apt-get update

COPY launch.sh /usr/local/bin/
COPY run-vnc.sh /usr/local/bin/

ENV WEB=/usr/share/novnc
ENTRYPOINT ["/usr/local/bin/run-vnc.sh"]
