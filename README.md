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
  official [Debian 8](https://console.cloud.google.com/marketplace/details/google/rbe-debian8)
  and [Ubuntu 16.04](https://console.cloud.google.com/marketplace/details/google/rbe-ubuntu16-04)
  images.
- An installation of [Buildbarn Browser](https://github.com/buildbarn/bb-browser).

Below is a diagram of what this setup Buildbarn looks like. In this
diagram, the arrows represent the direction in which network connections
are established.

<p align="center">
  <img src="https://github.com/buildbarn/bb-deployments/raw/master/bb-overview.png" alt="Overview of the Buildbarn setup"/>
</p>

## Using these deployments with Bazel

Bazel can perform remote builds against these deployments by adding
[the official Bazel toolchain definitions](https://releases.bazel.build/bazel-toolchains.html)
for the RBE container images to the `WORKSPACE` file of your project:

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_toolchains",
    sha256 = "109a99384f9d08f9e75136d218ebaebc68cc810c56897aea2224c57932052d30",
    strip_prefix = "bazel-toolchains-94d31935a2c94fe7e7c7379a0f3393e181928ff7",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-toolchains/archive/94d31935a2c94fe7e7c7379a0f3393e181928ff7.tar.gz",
        "https://github.com/bazelbuild/bazel-toolchains/archive/94d31935a2c94fe7e7c7379a0f3393e181928ff7.tar.gz",
    ],
)
```

In addition to that, you will need to add
[a list of generic build options](https://github.com/buildbarn/bb-deployments/blob/master/bazelrc)
to your `~/.bazelrc`, followed by the following set of options that are
specific to your environment:

```
build:mycluster-debian8 --config=remote
build:mycluster-debian8 --config=rbe-debian8
build:mycluster-debian8 --jobs=64
build:mycluster-debian8 --remote_executor=fill-in-your-cluster-hostname-here:8980
build:mycluster-debian8 --remote_instance_name=debian8

build:mycluster-ubuntu16-04 --config=remote
build:mycluster-ubuntu16-04 --config=rbe-ubuntu16-04
build:mycluster-ubuntu16-04 --jobs=64
build:mycluster-ubuntu16-04 --remote_executor=fill-in-your-cluster-hostname-here:8980
build:mycluster-ubuntu16-04 --remote_instance_name=ubuntu16-04
```

Once added, you may perform remote builds against Buildbarn by running
one of the commands below:

```
bazel build --config=mycluster-debian8 //...
bazel build --config=mycluster-ubuntu16-04 //...
```
