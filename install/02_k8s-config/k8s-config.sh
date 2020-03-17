#!/bin/bash
workdir=$(cd $(dirname $0); pwd)
namespaces_file=$workdir/namespaces
limit_file=$workdir/default-limits.yaml
secrect_file=$workdir/registry-secret.yaml
tmpdir=$workdir/tmp

mkdir -p $tmpdir
# create namespaces
# create Initialization configuration for each namespace (eg: secret,LimitRange,podpreset)
echo "== Start creating the namespace and apply -f $workdir/config..."
for namespace in `cat $namespaces_file`
do
    # create namespaces
    if [ $namespace == "kube-system" ]; then
         kubectl -n $namespace apply -f $workdir/config/registry-secret.yaml
    elif [ $namespace != "default" ]; then
        kubectl create namespace $namespace
    fi
    kubectl -n $namespace apply -f $workdir/config
    sed "s/NAMESPACE/$namespace/g" template/podpreset-template.yaml > $tmpdir/yaml-podpreset/podpreset-$namespace.yaml
done

echo "== Start creating the podpreset..."
mkdir -p $tmpdir/yaml-podpreset
kubectl apply -f $tmpdir/yaml-podpreset

# label nodes
echo "== Start labeling the nodes..."
for num in 001; do
    kubectl label nodes prdi-k8snode$num manage=
done

for num in 001 002; do
    kubectl label nodes prdi-k8snode$num nginx=prd
    kubectl label nodes prdi-k8snode$num env=uat
    kubectl label nodes prdi-k8snode$num java=
    kubectl label nodes prdi-k8snode$num frontend=
    kubectl label nodes prdi-k8snode$num backend=
done

for num in 003 004; do
    kubectl label nodes prdi-k8snode$num nginx=uat
    kubectl label nodes prdi-k8snode$num env=prd
    kubectl label nodes prdi-k8snode$num java=
    kubectl label nodes prdi-k8snode$num frontend=
    kubectl label nodes prdi-k8snode$num backend=
done

kubectl get nodes --show-labels

#