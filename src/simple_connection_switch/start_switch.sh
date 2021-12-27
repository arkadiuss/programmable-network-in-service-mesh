#!/bin/bash
#https://dev.to/polarbit/how-docker-container-networking-works-mimic-it-using-linux-network-namespaces-9mj
mkdir -p /var/run/netns/

SERVER_NAME="simple_connection_switch_server"
SERVER_NETWORK_NAME="${SERVER_NAME}_net"
SERVER_VETH_INTERNAL_NAME="veth_s1"
SERVER_VETH_EXTERNAL_NAME="server_veth"
CLIENT_NAME="simple_connection_switch_client"
CLIENT_NETWORK_NAME="${CLIENT_NAME}_net"
CLIENT_VETH_INTERNAL_NAME="veth_c1"
CLIENT_VETH_EXTERNAL_NAME="client_veth"

ip netns delete $SERVER_NETWORK_NAME
ip netns delete $CLIENT_NETWORK_NAME

server_pid=$(sudo docker inspect -f '{{.State.Pid}}' $SERVER_NAME)
echo "Server PID: $server_pid"
ln -sfT /proc/${server_pid}/ns/net /var/run/netns/$SERVER_NETWORK_NAME

client_pid=$(docker inspect -f '{{.State.Pid}}' $CLIENT_NAME)
echo "Client PID: $client_pid"
ln -sfT /proc/${client_pid}/ns/net /var/run/netns/$CLIENT_NETWORK_NAME

echo "Creating veths"
sudo ip link delete $SERVER_VETH_EXTERNAL_NAME
sudo ip link delete $CLIENT_VETH_EXTERNAL_NAME
ip link add $SERVER_VETH_INTERNAL_NAME type veth peer name $SERVER_VETH_EXTERNAL_NAME
ip link add $CLIENT_VETH_INTERNAL_NAME type veth peer name $CLIENT_VETH_EXTERNAL_NAME
echo "Current ns"
ip netns list
echo "Setting namespaces for veths"
ip link set $SERVER_VETH_INTERNAL_NAME netns $SERVER_NETWORK_NAME
ip link set $CLIENT_VETH_INTERNAL_NAME netns $CLIENT_NETWORK_NAME
echo "setting Ip addresses"
ip netns exec $SERVER_NETWORK_NAME ip addr flush dev $SERVER_VETH_INTERNAL_NAME
ip netns exec $SERVER_NETWORK_NAME ip addr add 10.2.1.2/24 dev $SERVER_VETH_INTERNAL_NAME
ip netns exec $SERVER_NETWORK_NAME ip link set $SERVER_VETH_INTERNAL_NAME up
ip addr flush dev $SERVER_VETH_EXTERNAL_NAME
ip addr add 10.2.1.1/24 dev $SERVER_VETH_EXTERNAL_NAME
ip link set $SERVER_VETH_EXTERNAL_NAME up

ip netns exec $CLIENT_NETWORK_NAME ip addr flush dev $CLIENT_VETH_INTERNAL_NAME
ip netns exec $CLIENT_NETWORK_NAME ip addr add 10.2.2.2/24 dev $CLIENT_VETH_INTERNAL_NAME
ip netns exec $CLIENT_NETWORK_NAME ip link set $CLIENT_VETH_INTERNAL_NAME up
ip addr flush dev $CLIENT_VETH_EXTERNAL_NAME
ip addr add 10.2.2.1/24 dev $CLIENT_VETH_EXTERNAL_NAME
ip link set $CLIENT_VETH_EXTERNAL_NAME up
echo "Final conf"
ip netns exec $SERVER_NETWORK_NAME ip addr
ip netns exec $CLIENT_NETWORK_NAME ip addr
echo "Starting Simple Switch"
cd switch
make build
cd ..
simple_switch_grpc -i 0@$SERVER_VETH_EXTERNAL_NAME -i 1@$CLIENT_VETH_EXTERNAL_NAME switch/build/basic.json