#!/usr/bin/env sh
set -eu

export PUBLIC_API_URI=${PUBLIC_API_URI:-http://192.168.1.254:8080}
envsubst '${PUBLIC_API_URI}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

nginx

# consul agent -server=false -join=consul-server -data-dir=/var/consul &

exec "$@"