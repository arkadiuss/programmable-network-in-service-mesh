#!/usr/bin/env sh
set -eu

export PRODUCT_DB_IP=${PRODUCT_DB_IP:-192.168.1.250}
export PRODUCT_DB_PORT=${PRODUCT_DB_PORT:-9567}
jq '.db_connection="host='$PRODUCT_DB_IP' port='$PRODUCT_DB_PORT' user=dbuser1 password=supersecret dbname=products sslmode=disable"' /conf.template.json > /conf.json 
cat /conf.json

sleep 10
consul agent -server=false -join=192.168.1.200 -data-dir=/var/consul &

sleep 10
consul services register /register/product-api.hcl
exec "$@"