# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install etersoft-build-utils git-core libuniset2-extension-common-devel libuniset2-utils ccache gcc5-c++ sudo su \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && apt-get clean \
    && rm -rf /etc/apt/sources.list.d/* \
    && apt-get update

ARG USER=builder
ARG HOME=/home/$USER
ARG TMPDIR=/tmp/$USER

RUN useradd builder
RUN control su public
COPY .rpmmacros $HOME/
RUN mkdir -p $TMPDIR

RUN chown $USER:$USER $HOME/.rpmmacros $TMPDIR
ENV USER="$USER" TMPDIR="$TMPDIR" GCC_USE_CCACHE=1 CCACHE_DIR="$HOME/.ccache"

USER "$USER"
CMD ["/bin/bash"]
