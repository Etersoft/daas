# DAAS: THIS IS DEFAULT Dockerfile template! Are you sure you wanted this?

# Version: 0.0.1
FROM fotengauer/altlinux-p8
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN apt-get update \
	&& apt-get -y install libuniset2-extension-common libuniset2-utils libomniORB-names mc \
	openssh-clients openssh-server console-scripts \
	&& apt-get clean \
	&& rm -rf /usr/share/doc/* \
	&& rm -rf /usr/share/man/* \
	&& rm -rf /etc/apt/sources.list.d/* \
	&& apt-get update

# set LANG for root
COPY root.i18n /root/.i18n

{%- if node['apt']['sources_list_filename'] %}
# project sources
COPY {{ node['apt']['sources_list_filename'] }} /etc/apt/sources.list.d/
{%- endif %}

{%- if 'packages' in node['apt'] and node['apt']['packages']|length > 0 %}
# install special packages
RUN ( apt-get update || echo "ignore update packages error" ) && apt-get -y install {% for v in node['apt']['packages'] %}{{ v }} {% endfor %}&& apt-get clean
{%- endif %}

{%- if 'copy' in node and node['copy']|length > 0 %}
# copyies for project
{%- for v in node['copy'] %}
COPY {{ v['src'] }} {{ v['dest'] }}
{%- if 'chmod' in v %}
{%- if v['dest'].endswith('/') %}
RUN chmod {{ v['chmod'] }} {{ v['dest'] }}{{ v['src'] }}
{%- else %}
RUN chmod {{ v['chmod'] }} {{ v['dest'] }}
{%- endif %}
{%- endif %}
{%- endfor %}
{%- endif %}

{%- if 'before_command' in node and node['before_command']|length > 0 %}
# 'before' commands
{%- for v in node['before_command'] %}
RUN  {{ v }}
{%- endfor %}
{%- endif %}

# start default services
RUN service sshd start
RUN service consolesaver start

{%- if 'start_command' in node %}
COPY {{ node['start_command'] }} /usr/bin/
CMD ["{{ node['start_command'] }}"]
{% else %}
CMD ["/bin/bash"]
{%- endif %}
