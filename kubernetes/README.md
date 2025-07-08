# Buildbarn deployment for Kubernetes

These manifests can be used to set up a full Buildbarn cluster on
Kubernetes. The cluster can be created by running the following command:

```sh
kubectl apply -k .
```

These files assume that the cluster needs to be created in the
`buildbarn` namespace. Storage is backed by persistent volumes.

## Recommendations for cluster operators

It is desirable to set the
[CPU requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits)
for bb\_runner containers to a fixed value, so that the running times of
actions remain consistent. However, even if these are set, functions
like Python's [`os.process_cpu_count()`](https://docs.python.org/3/library/os.html#os.process_cpu_count)
and Go's [`runtime.NumCPU()`](https://pkg.go.dev/runtime#NumCPU) may
report the number of CPU cores present on the system itself. This causes
applications that launch thread pools based on CPU core count to exhibit
heavy throttling. Cluster operators are therefore advised to enable the
[`static` CPU management policy](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/#static-policy-configuration),
so that bb\_runner containers can be assigned to dedicated CPU cores.

Recent versions of Kubernetes have migrated to
[cgroups v2](https://kubernetes.io/docs/concepts/architecture/cgroups/).
This caused a subtle change where if a process causes a container to
reach its memory limit, all processes belonging to that container are
killed by the Out Of Memory (OOM) killer. For Buildbarn this is
problematic, as it means that bb\_runner gets killed as well. Kubernetes
1.32 and later make it possible to restore the old behavior by enabling
[the `singleProcessOOMKill` option in the Kubelet configuration](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1/).
