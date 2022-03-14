#!/usr/bin/env sh
set -eu

envsubst '${PUBLIC_API_URI}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

nginx

consul agent -server=false -join=consul-server -data-dir=/var/consul &

exec "$@"