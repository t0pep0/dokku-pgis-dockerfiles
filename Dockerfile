# forked from https://gist.github.com/jpetazzo/5494158

FROM	ubuntu:quantal
MAINTAINER	fermuch "fermuch@gmail.com"
# Based on kload's (kload@kload.fr)

# prevent apt from starting postgres right after the installation
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN apt-get update
RUN	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y -q postgresql-9.1 postgresql-contrib-9.1 postgresql-9.1-postgis postgis wget libpq-dev postgresql-server-dev-9.1 libxml2-dev libgdal-dev gdal-bin libproj-dev build-essential
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean
RUN wget http://download.osgeo.org/postgis/source/postgis-2.1.0.tar.gz
RUN tar xvf postgis-2.1.0.tar.gz
RUN cd postgis-2.1.0; ./configure --with-pgconfig=/usr/bin/pg_config
RUN cd postgis-2.1.0; make
RUN cd postgis-2.1.0; make comments
RUN cd postgis-2.1.0; make install
RUN rm postgis-2.1.0.tar.gz
RUN rm -r postgis-2.1.0


# allow autostart again
RUN	rm /usr/sbin/policy-rc.d

ADD	. /usr/bin
RUN chmod +x /usr/bin/start_pgsql.sh
RUN chmod +x /usr/bin/add_postgis.sh
RUN echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.1/main/pg_hba.conf
RUN sed -i -e"s/var\/lib/opt/g" /etc/postgresql/9.1/main/postgresql.conf
