# DAAS: THIS IS DEFAULT Dockerfile template! Are you sure you wanted this?

# Version: 0.0.1
FROM alt:p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update \
	&& apt-get -y install mc openssh-clients openssh-server console-scripts \
	&& apt-get clean \
	&& rm -rf /usr/share/doc/* \
	&& rm -rf /usr/share/man/* \
	&& rm -rf /etc/apt/sources.list.d/* \
	&& apt-get update

{% include "base/Dockerfile.basic.tpl" %}

# start default services
RUN service sshd start
RUN service consolesaver start

{%- include "base/Dockerfile.start-command.tpl" %}
