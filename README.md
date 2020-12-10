# Example deployments of Buildbarn

This repository contains a set of scripts and configuration files that
can be used to deploy Buildbarn on various platforms. Buildbarn is
pretty flexible, in that it can both be used for single-node remote
caching setups and large-scale remote execution setups. Unless noted
otherwise, the configurations in this repository all use assume the
following setup:

- [Sharded](https://en.wikipedia.org/wiki/Sharding) storage, using
  [the Buildbarn storage daemon](https://github.com/buildbarn/bb-storage).
  To apply the sharding to client RPCs, a separate set of stateless
  frontend servers is used to fan out requests.
- [Remote execution](https://github.com/buildbarn/bb-remote-execution)
  of build actions, using container images based on Google RBE's
  official [Ubuntu 16.04](https://console.cloud.google.com/marketplace/details/google/rbe-ubuntu16-04)
  image.
- An installation of [the Buildbarn Browser](https://github.com/buildbarn/bb-browser).
- An installation of [the Buildbarn Event Service](https://github.com/buildbarn/bb-event-service/).

Below is a diagram of what this setup Buildbarn looks like. In this
diagram, the arrows represent the direction in which network connections
are established.

<p align="center">
  <img src="bb-overview.png" alt="Overview of the Buildbarn setup"/>
</p>

# Getting started

This example aims to showcase a very simple build and test with remote execution using docker-compose as the deployment for Buildbarn. We will be compiling examples from the [abseil-hello](https://github.com/abseil/abseil-hello) project using Bazel.

## Recommended setup

First clone the repo and start up a docker-compose example:
```
git clone https://github.com/buildbarn/bb-deployments.git
cd bb-deployments/docker-compose
./run.sh
```

You may see initially see an error message along the lines of:
```
worker-ubuntu16-04_1  | xxxx/xx/xx xx:xx:xx rpc error: code = Unavailable desc = Failed to synchronize with scheduler: all SubConns are in TransientFailure, latest connection error: connection error: desc = "transport: Error while dialing dial tcp xxx.xx.x.x:xxxx: connect: connection refused"
```

This is usually because container of the worker has started before the scheduler and so it cannot connect. After a second or so, this error message should stop.

## Remote execution

Bazel can perform remote builds against these deployments by adding [the official Bazel toolchain definitions](https://releases.bazel.build/bazel-toolchains.html) for the RBE container images to the `WORKSPACE` file of your project. It is also possible to derive your own configuration files using the `rbe_autoconfig`. More information can be found by reading the documentation [here](https://github.com/bazelbuild/bazel-toolchains/blob/master/rules/rbe_repo.bzl).

After installing the bazel_toolchains repository in your `WORKSPACE`, ensure that the Worker & Runner configuration for the "worker-ubuntu16-04" image SHA matches the version that is expected from the toolchain version. Note: this SHA is must match both in the jsonnet configuration and the configuration used to pull and run the actual container (docker compose, kubernetes yaml, etc...)

```shell
cat $(bazel info output_base)/external/bazel_toolchains/configs/dependency-tracking/ubuntu1604.bzl
```

For this example, we have provided the necessary `WORKSPACE` setup already but we still need to create the `.bazelrc`. In a separate terminal to your docker-compose deployment, create your `.bazelrc` in the project root:
```
cd bb-deployments/
cp bazelrc .bazelrc

cat >> .bazelrc << EOF

build:mycluster --remote_executor=grpc://localhost:8980
build:mycluster --remote_instance_name=remote-execution

build:mycluster-ubuntu16-04 --config=mycluster
build:mycluster-ubuntu16-04 --config=rbe-ubuntu16-04
build:mycluster-ubuntu16-04 --jobs=64
EOF
```

Now try a build:
```
bazel build --config=mycluster-ubuntu16-04 @abseil-hello//:hello_main
```

The output should look something like:
```
INFO: 30 processes: 30 remote.
```

You can check to see if the binary has built successfully by trying:
```
bazel run --config=mycluster-ubuntu16-04 @abseil-hello//:hello_main
```

Equally, you can try to execute a test remotely:
```
bazel test --config=mycluster-ubuntu16-04 @abseil-hello//:hello_test
```

Which will give you an output containing something like:
```
INFO: 29 processes: 29 remote.
//:hello_test                                                            PASSED in 0.1s

Executed 1 out of 1 test: 1 test passes.
```

Next, we will try out the remote caching capability. If you clean your local build cache and then rerun a build:
```
bazel clean
bazel build --config=mycluster-ubuntu16-04 @abseil-hello//:hello_main
```

You'll see an output containing information that we hit the remote cache instead of executing on a worker.
