# Buildbarn deployment that doesn't use containers

The deployments based on container images allow you to easily spin up a
Buildbarn setup on Linux-based systems. As Buildbarn can also be used on
non-Linux systems, this directory contains scripts for launching
all of Buildbarn's processes directly. This setup uses the following
simplified configuration:

<p align="center">
  <img src="bb-overview-simplified.png" alt="Overview of the simplified Buildbarn setup"/>
</p>

Buildbarn can be launched by running
`bazel run -- //bare:bare [absolute-working-directory]`, which will fetch
and build the different Buildbarn binaries, start them, and load the
configuration found in the `config` directory. If no working directory is
specified, the default location will be inside Bazel's runfiles tree.

This deployment is known to work on FreeBSD, Linux and macOS.

# Using this deployment with Bazel

In addition to [the generic build options](../bazelrc),
the following options should be added to `~/.bazelrc`:

```
build:local --jobs=8
build:local --remote_executor=grpc://localhost:8980
build:local --remote_instance_name=local
```

Once added, you may perform remote builds against Buildbarn by running
the command below:

```
bazel build --config=local //...
```
