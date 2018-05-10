# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update && apt-get -y install libuniset2-extension-logdb uniset2-utils \
	&& apt-get clean \
	&& rm -rf /usr/share/doc/* \
	&& rm -rf /usr/share/man/* \
	&& rm -rf /etc/apt/sources.list.d/* \
	&& apt-get update

{% set logdb = project['logdb'] %}

{%- if logdb['apt']['sources_list_filename'] %}
# project sources
COPY {{ logdb['apt']['sources_list_filename'] }} /etc/apt/sources.list.d/
{%- endif %}

{%- if 'packages' in logdb['apt'] and logdb['apt']['packages']|length > 0 %}
# install special packages
RUN ( apt-get update || echo "ignore update packages error" ) && apt-get -y install {% for v in logdb['apt']['packages'] %}{{ v }} {% endfor %} && apt-get clean
{%- endif %}

COPY run-logdb.sh /usr/local/bin/
RUN mkdir -p /etc/logdb
COPY {{ project['name'] }}-logdb-conf.xml /etc/logdb/logdb-conf.xml

CMD ["run-logdb.sh"]
