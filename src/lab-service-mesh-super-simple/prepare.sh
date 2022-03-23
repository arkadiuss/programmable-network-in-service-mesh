#!/bin/bash

echo "Cleaning kathara state..."
kathara wipe -f
echo "Rebuilding docker images..."
bash -c 'cd /home/service-mesh-lab-build && docker-compose down && docker-compose build'
echo "Removing previous lab..."
rm -r lab
echo "Generating new one from script..."
chmod +x netkit.script
./netkit.script