#!/usr/bin/env sh
set -eu

sleep 10
consul agent -server=false -join=192.168.1.200 -data-dir=/var/consul &

sleep 10
consul services register /register/product-api.hcl
exec "$@"