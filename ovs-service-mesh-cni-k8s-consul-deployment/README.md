# Hashicups deployment integrated with k8s consul supported by programmable switches

## Getting started
Run cluster:
```
KUBEVIRT_NUM_NODES=2 make cluster-up
```
Config cluster:
```
export KUBEVIRT_PROVIDER=k8s-1.23
export KUBECONFIG=$(../../ovs-service-mesh-cni/_kubevirtci/cluster-up/kubeconfig.sh)
```
Setup OpenVSwitch on each node:
```
./node_setup <ip_of_the_other_node>
ovs-appctl -t ovsdb-server ovsdb-server/add-remote tcp:6641:0.0.0.0
```
Install consul:
```
consul-k8s install -auto-approve -config-file=helm/consul-values.yaml -set global.image=hashicorp/consul:1.11.4
```
Run `ovs-service-mesh-controller`:
```
go build -o bin/controller-gen
make build
```
Apply app:
```
kubectl apply -f k8s/
```

## Based on
- https://github.com/arkadiuss/ovs-service-mesh-cni/blob/main/docs/demo.md
- https://github.com/hashicorp-demoapp/hashicups-setups/tree/main/local-k8s-consul-deployment
- https://www.consul.io/docs/k8s/connect
- https://github.com/tczekajlo/kube-consul-register
