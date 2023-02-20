# Buildbarn deployment for Kubernetes

These manifests can be used to set up a full Buildbarn cluster on
Kubernetes. The cluster can be created by running the following command:

```sh
kubectl apply -k .
```

These files assume that the cluster needs to be created in the
`buildbarn` namespace. Storage is backed by persistent volumes.


**Prototyping/Quickstart**
To run against the cluster (for protyping & debugging), forward port 8980 in one terminal
```sh
while true; do kubectl --n buildbarn port-forward services/frontend <your-bazel-grpc-port>:8980; done
```

**Debugging**:
Check Pods are up and get logs within the pods
```sh
kubectl get pods -n buildbarn
kubectl logs <worker-ubuntu-pod-name> -n buildbarn
```

**Note**
- Yaml files here work for microk8s and k3s, but will not work straight out of the box for kubeadm