# Hashicups deployment integrated with k8s consul supported by programmable switches

## Getting started
Setup OpenVSwitch on each node:
```
./node_setup <ip_of_the_other_node>
```
Install consul:
```
consul-k8s install -auto-approve -config-file=helm/consul-values.yaml -set global.image=hashicorp/consul:1.11.4
```
Apply app:
```
kubectl apply -f k8s/
```

## Based on
- https://github.com/arkadiuss/ovs-service-mesh-cni/blob/main/docs/demo.md
- https://github.com/hashicorp-demoapp/hashicups-setups/tree/main/local-k8s-consul-deployment
- https://www.consul.io/docs/k8s/connect
