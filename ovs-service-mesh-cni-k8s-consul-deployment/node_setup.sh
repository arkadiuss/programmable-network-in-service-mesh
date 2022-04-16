#!/bin/sh

OTHER_NODE_IP_ADDRESS=$1

ovs-vsctl add-br br1
ovs-vsctl add-port br1 vxlan -- set Interface vxlan type=vxlan options:remote_ip=$OTHER_NODE_IP_ADDRESS
