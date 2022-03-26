#!/bin/sh

while true; do
    curl http://10.2.1.1:80 --max-time 2
    sleep 10
done