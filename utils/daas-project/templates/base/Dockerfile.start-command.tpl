{%- if 'start_command' in node and node['start_command'] != None %}
# node start command
COPY {{ node['start_command'] }} /usr/bin/
CMD ["{{ node['start_command'] }}"]
{% else %}
{%- set cmd = start_command if start_command is defined else '/bin/bash' %}
COPY {{cmd}} /usr/bin/
CMD ["{{cmd}}"]
{%- endif %}
