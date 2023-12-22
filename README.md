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
  of build actions, using container images from
  [Act](https://github.com/nektos/act/blob/master/IMAGES.md), distributed by
  [catthehacker](https://github.com/catthehacker/docker_images), used for
  running GitHub Actions locally under Ubuntu 22.04.
- An installation of [the Buildbarn Browser](https://github.com/buildbarn/bb-browser).

Below is a diagram of what this setup Buildbarn looks like. In this
diagram, the arrows represent the direction in which network connections
are established.

<p align="center">
  <img src="bb-overview.png" alt="Overview of the Buildbarn setup"/>
</p>

## Current versions

This repository currently demonstrates the following versions.
Binaries can be found under the CI Build link,
at the top right in the GitHub Actions page.

| Repository | Container images and binaries |
| ---------- | ----------------------------- |
| [bb-browser](https://github.com/buildbarn/bb-browser) [`794e38071d`](https://github.com/buildbarn/bb-browser/commits/794e38071d7a18babfc6c57643767d26415dcd63)<br/>2023-09-17 04:20:39 UTC | [ghcr.io/buildbarn/bb-browser:20231103T134227Z-794e380](https://ghcr.io/buildbarn/bb-browser:20231103T134227Z-794e380)<br/>[CI artifacts](https://github.com/buildbarn/bb-browser/actions/runs/6745964234) |
| [bb-remote-execution](https://github.com/buildbarn/bb-remote-execution) [`4b3a11b508`](https://github.com/buildbarn/bb-remote-execution/commits/4b3a11b508cf06a3dfa17f141b3ea505bc039434)<br/>2023-10-04 10:23:25 UTC | [ghcr.io/buildbarn/bb-runner-installer:20231222T105429Z-4b3a11b](https://ghcr.io/buildbarn/bb-runner-installer:20231222T105429Z-4b3a11b)<br/>[ghcr.io/buildbarn/bb-scheduler:20231222T105429Z-4b3a11b](https://ghcr.io/buildbarn/bb-scheduler:20231222T105429Z-4b3a11b)<br/>[ghcr.io/buildbarn/bb-worker:20231222T105429Z-4b3a11b](https://ghcr.io/buildbarn/bb-worker:20231222T105429Z-4b3a11b)<br/>[CI artifacts](https://github.com/buildbarn/bb-remote-execution/actions/runs/7299077275) |
| [bb-storage](https://github.com/buildbarn/bb-storage) [`e7766ceb04`](https://github.com/buildbarn/bb-storage/commits/e7766ceb0474084a480b1f05e144b30fec70efeb)<br/>2023-10-08 11:11:12 UTC | [ghcr.io/buildbarn/bb-storage:20231222T105222Z-e7766ce](https://ghcr.io/buildbarn/bb-storage:20231222T105222Z-e7766ce)<br/>[CI artifacts](https://github.com/buildbarn/bb-storage/actions/runs/7299060171) |

## Changelog

A changelog for each update to `bb-deployments` is maintained in [changelog.md](changelog.md).

The [Meroton blog](https://meroton.com/blog/tags/buildbarn/)
describes some of the changes and features in more detail
and includes Jsonnet configuration migration examples.

# Getting started

This example aims to showcase a very simple build and test with remote execution
using docker-compose as the deployment for Buildbarn. We will be compiling
examples from the [abseil-hello](https://github.com/abseil/abseil-hello) project
using Bazel.

## Recommended setup

First clone the repo and start up a docker-compose example:
```
git clone https://github.com/buildbarn/bb-deployments.git
cd bb-deployments/docker-compose
./run.sh
```

You may see initially see an error message along the lines of:
```
worker-ubuntu22-04_1  | xxxx/xx/xx xx:xx:xx rpc error: code = Unavailable desc = Failed to ...: connection error: desc = "transport: Error while dialing dial tcp xxx.xx.x.x:xxxx: connect: connection refused"
```

This is usually because container of the worker has started before the scheduler
or runner and so it cannot connect to them. After a second or so, this error
message should stop.

## Remote execution

Bazel can perform remote builds against these deployments by using toolchains
adapted to the remote environment. The script
`tools/remote-toolchains/extract-bazel-auto-toolchains.sh` has been used to
construct such a C++ toolchain which is activated using
`--config=remote-ubuntu-22-04`, see `.bazelrc` and `WORKSPACE` for the exact
setup.

Note that the name and SHA of the container image is configured in multiple
places: `BUILD.bazel`, `.jsonnet` configuration for Buildbarn and for the actual
runner container (docker compose, kubernetes yaml, etc...)

Now try a build (using `bazel` or [`bazelisk`](https://github.com/bazelbuild/bazelisk)):
```
bazel build --config=remote-ubuntu-22-04 @abseil-hello//:hello_main
```

The output should look something like:
```
INFO: 33 processes: 4 internal, 29 remote.
INFO: Build completed successfully, 33 total actions
```

You can check to see if the binary has built successfully by trying:
```
bazel run --config=remote-ubuntu-22-04 @abseil-hello//:hello_main
```
You may experience problems with wrong version of glibc compared to what the
remote is building for.

Equally, you can try to execute a test remotely:
```
bazel test --config=remote-ubuntu-22-04 @abseil-hello//:hello_test
```

Which will give you an output containing something like:
```
INFO: 49 processes: 4 internal, 45 remote.
INFO: Build completed successfully, 49 total actions
@abseil-hello//:hello_test                                     PASSED in 0.1s

Executed 1 out of 1 test: 1 test passes.
```
You might experience problems loading `abseil-hellos/libhello.so`, in which case
you can link statically by using `--dynamic_mode=off`.

Next, we will try out the remote caching capability. If you clean your local
build cache and then rerun a build:
```
bazel clean
bazel build --config=remote-ubuntu-22-04 @abseil-hello//:hello_main
```

You'll see an output containing information that we hit the remote cache instead
of executing on a worker.

## Other Build Clients

### Buck2

There is a Buildbarn example in the Buck2 repository: [here](https://github.com/facebook/buck2/tree/main/examples/remote_execution/buildbarn)
Platform properties are defined in [platform/defs.bzl](https://github.com/facebook/buck2/blob/main/examples/remote_execution/buildbarn/platforms/defs.bzl)
and the rpc endpoints are set in [.buckconfig](https://github.com/facebook/buck2/blob/main/examples/remote_execution/buildbarn/.buckconfig).

### Pants

Pants defines the endpoint and the properties in the main configuration file `pants.toml`.

```
[GLOBAL]
remote_cache_read = true
remote_cache_write = true
remote_store_address = "grpc://localhost:8980"
remote_execution_address = "grpc://localhost:8980"
remote_execution = true
remote_instance_name = "fuse"
remote_execution_extra_platform_properties = [
  "OSFamily=linux",
  "container-image=docker://ghcr.io/catthehacker/ubuntu:act-22.04@sha256:5f9c35c25db1d51a8ddaae5c0ba8d3c163c5e9a4a6cc97acd409ac7eae239448",
]
```

### Goma

It is possible to use `goma`, the buildsystem in the `chromium` project with `Buildbarn`.
The instructions are available here: [docs/goma.md].

### Bazel without a remote toolchain

You do not need to define a toolchain for remote execution, like this repository does.
For simple projects where all actions can build with the same executors
you can use set the platform properties as command line arguments.

```
bazel build \
    --remote_executor=grpc://localhost:8980 \
    --remote_instance_name=fuse \
    --remote_default_exec_properties OSFamily=linux \
    --remote_default_exec_properties container-image="docker://ghcr.io/catthehacker/ubuntu:act-22.04@sha256:5f9c35c25db1d51a8ddaae5c0ba8d3c163c5e9a4a6cc97acd409ac7eae239448" \
    @abseil-hello//:hello_main
```

# Join us on Slack!

There is a [#buildbarn channel on buildteamworld.slack.com](https://bit.ly/2SG1amT)
that you can join to get in touch with other people who use and hack on
Buildbarn.

# Commercial Support

Buildbarn has an active and enthusiastic community. Though we try to help and
support those who have issues or questions, sometimes organisations need more
dedicated support. The following is a list of community members who you can
contact if you require commercial support. Please submit a PR if you wish to
have your name listed here. Having a name listed is not necessarily an
endorsement.

- [Finn Ball](mailto:finn.ball@codificasolutions.com) - Freelance Consultant
- [Fredrik Medley](mailto:fredrik@meroton.com) - Consultant

## Commercial Hosting and Professional Services

[Meroton](https://www.meroton.com/services/) - Cloud Hosted Buildbarn and Services

Buildbarn does not encourage commercial forks and is willing to engage with
organisations to merge changes upstream in order to be maintained by the
community.

# Maintenance instructions

## Updating Buildbarn version

First make sure the different Buildbarn components are in sync. Then perform:

```bash
# Update go.mod.
go mod tidy -e

# Regenerate go_dependencies.bzl.
bazel run //:gazelle -- update-repos -from_file=go.mod -to_macro go_dependencies.bzl%go_dependencies -prune
# Format go_dependencies.bzl according to GitHub Actions.
sed -i '/^$/d' go_dependencies.bzl
bazelisk run @com_github_bazelbuild_buildtools//:buildifier

# Update the Kubernetes and Docker compose deployments.
./tools/update-container-image-versions.sh
```

You might have to update the `WORKSPACE` file as well,
until `MODULE.bazel` is in place.

## Formatting

A number of linting and formatting steps are performed in the GitHub Actions flow.
Some of the steps are:

```bash
# Gazelle
bazel run //:gazelle -- update-repos -from_file=go.mod -to_macro go_dependencies.bzl%go_dependencies -prune
bazel run //:gazelle
# Buildifier
sed '/^$/d' go_dependencies.bzl > go_dependencies.bzl.new
mv go_dependencies.bzl.new go_dependencies.bzl
bazel run @com_github_bazelbuild_buildtools//:buildifier
# Gofmt
bazel run @cc_mvdan_gofumpt//:gofumpt -- -lang 1.19 -w -extra $(pwd)
# Golint
bazel run @org_golang_x_lint//golint -- -set_exit_status $(pwd)/...
```
