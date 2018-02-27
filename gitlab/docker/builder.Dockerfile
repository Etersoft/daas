# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install etersoft-build-utils git-core libuniset2-extension-common-devel libuniset2-utils ccache gcc5-c++ su sudo

RUN useradd builder
RUN control su public
RUN mkdir -p /home/builder/build && chown builder:builder /home/builder/build
USER "builder"
CMD ["/bin/bash"]
