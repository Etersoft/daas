{% for s in node['apt']['sources'] %}
{{ s }}
{%- endfor %}
