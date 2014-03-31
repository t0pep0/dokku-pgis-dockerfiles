#!/usr/bin/env bash

if [[ $1 && $2 ]]; then
  # $1 = DB_PASSWORD
  # $2 = PORT  
  printf "Password: %s\nPORT: %s" "${1}" "${2}"
  PGPASSWORD=$1 psql -h 172.17.42.1 -p "${2}" -d db -c"CREATE EXTENSION postgis;"
  PGPASSWORD=$1 psql -h 172.17.42.1 -p "${2}" -d db -c"CREATE EXTENSION postgis_topology;"
  PGPASSWORD=$1 psql -h 172.17.42.1 -p "${2}" -d db -c"CREATE EXTENSION fuzzystrmatch;"
  PGPASSWORD=$1 psql -h 172.17.42.1 -p "${2}" -d db -c"CREATE EXTENSION postgis_tiger_geocoder;"
fi
