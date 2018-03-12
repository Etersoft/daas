# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install uniset2-testsuite python-module-pip \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && apt-get clean \
    && rm -rf /etc/apt/sources.list.d/* \
    && apt-get update \
    && pip install docker-compose==1.18.0 \
    && pip install docker
COPY start-project.sh /usr/bin/
#RUN useradd tester
#USER "tester"
CMD ["/bin/bash"]
