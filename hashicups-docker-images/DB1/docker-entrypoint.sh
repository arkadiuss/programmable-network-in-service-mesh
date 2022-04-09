#!/usr/bin/env sh
set -eu

consul agent -server=false -join=consul_server -data-dir=/var/consul &

sleep 10
consul services register /register/db.hcl

exec "$@"