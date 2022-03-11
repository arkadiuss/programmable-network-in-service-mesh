#!/usr/bin/env sh
set -eu

envsubst '${PUBLIC_API_URI}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

nginx

exec "$@"