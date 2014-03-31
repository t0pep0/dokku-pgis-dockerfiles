#!/usr/bin/env bash

if [[ $1 && $2 ]]; then
  # $1 = DB_PASSWORD
  # $2 = PORT  
  echo "${1} ${2}"
  psql -h 172.17.42.1 -p "${2}" -d db <<< "CREATE EXTENSION postgis;"
  psql -h 172.17.42.1 -p "${2}" -d db <<< "CREATE EXTENSION postgis_topology;"
  psql -h 172.17.42.1 -p "${2}" -d db <<< "CREATE EXTENSION fuzzystrmatch;"
  psql -h 172.17.42.1 -p "${2}" -d db <<< "CREATE EXTENSION postgis_tiger_geocoder;"
fi
