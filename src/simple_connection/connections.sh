#!/bin/bash

mkdir -p /var/run/netns/

server_pid=$(sudo docker inspect -f '{{.State.Pid}}' simple_connection_server)
echo "Server PID: $server_pid"
ln -sfT /proc/${server_pid}/ns/net /var/run/netns/simple_connection_server

client_pid=$(docker inspect -f '{{.State.Pid}}' simple_connection_client)
echo "Client PID: $client_pid"
ln -sfT /proc/${client_pid}/ns/net /var/run/netns/simple_connection_client

echo "Creating veths"
sudo ip link delete veth_server
sudo ip link delete veth_client
ip link add veth_server type veth peer name veth_client
echo "Current ns"
ip netns list
echo "Setting namespaces for veths"
ip link set veth_server netns simple_connection_server
ip link set veth_client netns simple_connection_client
echo "setting Ip addresses"
ip netns exec simple_connection_server ip addr flush dev veth_server
ip netns exec simple_connection_server ip addr add 10.1.1.1/24 dev veth_server
ip netns exec simple_connection_server ip link set veth_server up
ip netns exec simple_connection_client ip addr flush dev veth_client
ip netns exec simple_connection_client ip addr add 10.1.1.2/24 dev veth_client
ip netns exec simple_connection_client ip link set veth_client up
echo "Final conf"
ip netns exec simple_connection_client ip addr
ip netns exec simple_connection_server ip addr
