#!/usr/bin/env sh
set -eu

consul agent -server=false -join=consul-server -data-dir=/var/consul &

exec "$@"