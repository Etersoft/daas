# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update \
	&& apt-get -y install libuniset2-extension-common libuniset2-utils libomniORB-names mc \
	openssh-clients openssh-server glibc-locales console-scripts \
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
