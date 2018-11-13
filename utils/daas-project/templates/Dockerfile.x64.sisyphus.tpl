# Version: 0.0.1
FROM alt:sisyphus
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
RUN rm -rf /usr/share/doc/* \
	&& rm -rf /usr/share/man/* \
	&& rm -rf /etc/apt/sources.list.d/*

{% set lang_disabled="1" %}
{% include "base/Dockerfile.basic.tpl" %}

{%- include "base/Dockerfile.start-command.tpl" %}
