# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install uniset2-testsuite python-module-pip libuniset2-utils mc \
    openssh-clients openssh-server expect glibc-locales hostinfo pssh \
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && apt-get clean \
    && rm -rf /etc/apt/sources.list.d/* \
    && apt-get update \
    && pip install docker-compose==1.18.0 \
    && pip install docker

{%- if node['apt']['sources_list_filename'] %}
COPY {{ node['apt']['sources_list_filename'] }} /etc/apt/sources.list.d/
{%- endif %}

{%- if 'packages' in node['apt'] %}
# install special packages
RUN apt-get update -m && apt-get -y install {% for v in node['apt']['packages'] %}{{ v }} {% endfor %}&& apt-get clean
{%- endif %}

{%- if 'start_command' in node %}
COPY {{ node['start_command'] }} /usr/bin/
CMD ["{{ node['start_command'] }}"]
{% else %}
CMD ["/bin/bash"]
{%- endif %}
