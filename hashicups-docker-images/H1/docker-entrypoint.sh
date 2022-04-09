#!/usr/bin/env sh
set -eu

export PUBLIC_API_URI=${PUBLIC_API_URI:-http://192.168.1.250:9191}
envsubst '${PUBLIC_API_URI}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

nginx

sleep 10
consul agent -server=false -join=192.168.1.200 -data-dir=/var/consul &

sleep 10
consul services register /register/frontend.hcl
consul services register /register/public-api.hcl
exec "$@"