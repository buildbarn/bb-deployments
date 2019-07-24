for run in $(bazel query //... | grep -e "_container_push\$")
do
    bazel --bazelrc=/bazelrc run --host_force_python=PY2 $run
done
