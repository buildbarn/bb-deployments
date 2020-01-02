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
    sha256 = "04b10647f76983c9fb4cc8d6eb763ec90107882818a9c6bef70bdadb0fdf8df9",
    strip_prefix = "bazel-toolchains-1.2.4",
    urls = [
        "https://github.com/bazelbuild/bazel-toolchains/releases/download/1.2.4/bazel-toolchains-1.2.4.tar.gz",
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-toolchains/archive/1.2.4.tar.gz",
    ],
)

load("@bazel_toolchains//rules:rbe_repo.bzl", "rbe_autoconfig")

rbe_autoconfig(name = "rbe_default")
```

In addition to that, you will need to add
[a list of generic build options](https://github.com/buildbarn/bb-deployments/blob/master/bazelrc)
to your `~/.bazelrc`, followed by the following set of options that are
specific to your environment:

```
build:mycluster --bes_backend=grpc://fill-in-the-event-service-hostname-here:8985
build:mycluster --bes_results_url=http://fill-in-the-browser-service-hostname-here/build_events/bb-event-service/
build:mycluster --remote_executor=grpc://fill-in-the-frontend-service-hostname-here:8980
build:mycluster --remote_instance_name=remote-execution

build:mycluster-ubuntu16-04 --config=mycluster
build:mycluster-ubuntu16-04 --config=rbe-ubuntu16-04
build:mycluster-ubuntu16-04 --jobs=64
```

Once added, you may perform remote builds against Buildbarn by running
the command below:

```
bazel build --config=mycluster-ubuntu16-04 //...
```
