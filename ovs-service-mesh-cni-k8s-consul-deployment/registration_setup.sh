#/bin/bash
VERSION=0.1.9
wget https://github.com/tczekajlo/kube-consul-register/archive/refs/tags/v$VERSION.zip -O kube-consul-register-v$VERSION.zip
unzip kube-consul-register-v$VERSION.zip
cd kube-consul-register-$VERSION
make build
mv dist/kube-consul-register ..
cd ..
rm -r kube-consul-register-$VERSION kube-consul-register-v$VERSION.zip

# kubectl apply -f kube-consul-register-config-map.yml
# ./kube-consul-register -logtostderr=true -kubeconfig=/$(../../ovs-service-mesh-cni/_kubevirtci/cluster-up/kubeconfig.sh) -configmap="default/kube-consul-register" -in-cluster=false