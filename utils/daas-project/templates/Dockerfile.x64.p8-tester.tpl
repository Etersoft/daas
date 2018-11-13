# Version: 0.0.1
FROM alt:p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install uniset2-testsuite python-module-pip libuniset2-utils mc \
    openssh-clients openssh-server expect glibc-locales hostinfo pssh console-scripts docker-compose \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && apt-get clean \
    && rm -rf /etc/apt/sources.list.d/* \
    && apt-get update

{% include "base/Dockerfile.basic.tpl" %}

# start default services
RUN service sshd start
RUN service consolesaver start

{%- include "base/Dockerfile.start-command.tpl" %}
