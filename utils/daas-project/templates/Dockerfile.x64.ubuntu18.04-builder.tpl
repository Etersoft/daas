# Version: 0.0.1
FROM ubuntu:18.04
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install autoconf automake autogen libtool g++-8 ccache sudo \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && apt-get clean \
    && rm -rf /etc/apt/sources.list.d/* \
    && apt-get update

{% include "base/Dockerfile.basic.tpl" %}

# prepare build user
ARG USER=builder
ARG HOME=/home/$USER
ARG TMPDIR=$HOME/tmp

ARG USER_UID=''
RUN test -n "$USER_UID" && useradd -u $USER_UID builder || useradd builder

COPY .rpmmacros $HOME/
COPY .gitconfig $HOME/

RUN mkdir -p $TMPDIR

RUN chown $USER:$USER $HOME/.rpmmacros $HOME/.gitconfig $TMPDIR
ENV USER="$USER" TMP="$TMPDIR" TMPDIR="$TMPDIR" GCC_USE_CCACHE=1 CCACHE_DIR="$HOME/ccache"

USER "$USER"

{% set start_command="daas-builder-start.sh" %}
{%- include "base/Dockerfile.start-command.tpl" %}
