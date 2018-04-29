# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update \
	&& apt-get -y install libuniset2-extension-common libuniset2-utils libomniORB-names mc openssh-clients openssh-server \
	&& apt-get clean \
	&& rm -rf /usr/share/doc/* \
	&& rm -rf /usr/share/man/* \
	&& rm -rf /etc/apt/sources.list.d/* \
	&& apt-get update
{% if 'packages' in node['apt'] %}
# install special packages
RUN apt-get -y install {% for v in node['apt']['packages'] %}{{ v }} {% endfor %}&& apt-get clean
{% endif %}

#COPY local.list /etc/apt/sources.list.d/
#RUN apt-get update
RUN service ssh start
COPY start-project.sh /usr/bin/
CMD ["/usr/bin/start-project.sh"]
