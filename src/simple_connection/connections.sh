#!/bin/bash
#https://dev.to/polarbit/how-docker-container-networking-works-mimic-it-using-linux-network-namespaces-9mj
mkdir -p /var/run/netns/

SERVER_NAME="simple_connection_server"
SERVER_NETWORK_NAME="${SERVER_NAME}_net"
CLIENT_NAME="simple_connection_client"
CLIENT_NETWORK_NAME="${CLIENT_NAME}_net"

ip netns delete $SERVER_NETWORK_NAME
ip netns delete $CLIENT_NETWORK_NAME

server_pid=$(docker inspect -f '{{.State.Pid}}' $SERVER_NAME)
echo "Server PID: $server_pid"
ln -sfT /proc/${server_pid}/ns/net /var/run/netns/$SERVER_NETWORK_NAME

client_pid=$(docker inspect -f '{{.State.Pid}}' $CLIENT_NAME)
echo "Client PID: $client_pid"
ln -sfT /proc/${client_pid}/ns/net /var/run/netns/$CLIENT_NETWORK_NAME

echo "Creating veths"
ip link delete veth_server
ip link delete veth_client
ip link add veth_server type veth peer name veth_client
echo "Current ns"
ip netns list
echo "Setting namespaces for veths"
ip link set veth_server netns $SERVER_NETWORK_NAME
ip link set veth_client netns $CLIENT_NETWORK_NAME
echo "setting Ip addresses"
ip netns exec $SERVER_NETWORK_NAME ip addr flush dev veth_server
ip netns exec $SERVER_NETWORK_NAME ip addr add 10.1.1.1/24 dev veth_server
ip netns exec $SERVER_NETWORK_NAME ip link set veth_server up
ip netns exec $CLIENT_NETWORK_NAME ip addr flush dev veth_client
ip netns exec $CLIENT_NETWORK_NAME ip addr add 10.1.1.2/24 dev veth_client
ip netns exec $CLIENT_NETWORK_NAME ip link set veth_client up
echo "Final conf"
ip netns exec $SERVER_NETWORK_NAME ip addr
ip netns exec $CLIENT_NETWORK_NAME ip addr
