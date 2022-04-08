#!/usr/bin/env sh
set -eu

consul agent -server=false -join=consul-server -data-dir=/var/consul &

sleep 10
consul services register /register/product-api.hcl
exec "$@"