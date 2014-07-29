# forked from https://gist.github.com/jpetazzo/5494158

FROM	ubuntu:trusty
MAINTAINER	fermuch "fermuch@gmail.com"
# Based on kload's (kload@kload.fr)

#Set utf-8
RUN export LC_ALL="C.UTF-8"

# prevent apt from starting postgres right after the installation
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN apt-get update
RUN	LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive apt-get install -y -q postgresql-9.3 postgresql-contrib-9.3 wget libpq-dev postgresql-server-dev-9.3 libxml2-dev libgdal-dev gdal-bin libproj-dev build-essential ostgresql-9.3-postgis
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

# allow autostart again
RUN	rm /usr/sbin/policy-rc.d

ADD	. /usr/bin
RUN chmod +x /usr/bin/start_pgsql.sh
RUN chmod +x /usr/bin/add_postgis.sh
RUN echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.3/main/pg_hba.conf
RUN sed -i -e"s/var\/lib/opt/g" /etc/postgresql/9.3/main/postgresql.conf
