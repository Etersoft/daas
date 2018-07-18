{% if lang_disabled is undefined %}
# set LANG for root
COPY root.i18n /root/.i18n
{% endif %}

{%- if node['apt']['sources_list_filename'] %}
# project sources
COPY {{ node['apt']['sources_list_filename'] }} /etc/apt/sources.list.d/
{%- endif %}

{%- if 'packages' in node['apt'] and node['apt']['packages']|length > 0 %}
# install special packages
RUN ( apt-get update || echo "ignore update packages error" ) && apt-get -y install {% for v in node['apt']['packages'] %}{{ v }} {% endfor %}&& apt-get clean
{%- endif %}

{%- if 'copy' in node and node['copy'] and node['copy']|length > 0 %}
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

