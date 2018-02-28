# Version: 0.0.1
FROM #BASE_IMAGE#
MAINTAINER Pavel Vainerman <pv@etersoft.ru>
# RUN apt-get update && apt-get -y install etersoft-build-utils git-core libuniset2-extension-common-devel libuniset2-utils ccache gcc5-c++ su sudo

RUN mkdir -p /home/builder/build 
COPY . /tmp/sources/

# RUN cp -r /tmp/sources /home/builder/build && cd /home/builder/build && rpmgp -i
USER "builder"
CMD ["/bin/bash"]
