# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install etersoft-build-utils git-core libuniset2-extension-common-devel libuniset2-utils ccache gcc5-c++ sudo su \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && apt-get clean \
    && rm -rf /etc/apt/sources.list.d/* \
    && apt-get update

RUN useradd builder
RUN control su public
USER "builder"
CMD ["/bin/bash"]
