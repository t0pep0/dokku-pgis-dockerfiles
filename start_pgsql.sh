#!/bin/bash
export LC_ALL="C.UTF-8"
if [[ ! -f /opt/postgresql/initialized ]]; then
    mkdir -p /opt/postgresql
    cp -a /var/lib/postgresql/* /opt/postgresql/
    chown -R postgres:postgres /opt/postgresql
    su postgres sh -c "/usr/lib/postgresql/9.3/bin/postgres --single  -D  /var/lib/postgresql/9.3/main  -c config_file=/etc/postgresql/9.3/main/postgresql.conf" <<< "CREATE USER root WITH SUPERUSER PASSWORD '$1';"
    su postgres sh -c "/usr/lib/postgresql/9.3/bin/postgres --single  -D  /var/lib/postgresql/9.3/main  -c config_file=/etc/postgresql/9.3/main/postgresql.conf" <<< "CREATE DATABASE db WITH ENCODING=UTF8 LC_COLLATE=C.UTF-8 LC_TYPE=C.UTF-8;"
    touch /opt/postgresql/initialized
fi
su postgres sh -c "/usr/lib/postgresql/9.3/bin/postgres           -D  /var/lib/postgresql/9.3/main  -c config_file=/etc/postgresql/9.3/main/postgresql.conf  -c listen_addresses=*"
