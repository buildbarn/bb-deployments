# Buildbarn deployment that doesn't use containers

The deployments based on container images allow you to easily spin up a
Buildbarn setup on Linux-based systems. As Buildbarn can also be used on
non-Linux systems, this directory contains scripts for launching
all of Buildbarn's processes directly. This setup uses the following
simplified configuration:

<p align="center">
  <img src="https://github.com/buildbarn/bb-deployments/raw/master/bare/bb-overview-simplified.png" alt="Overview of the simplified Buildbarn setup"/>
</p>

Buildbarn can be launched by running `run.sh`, providing it paths of
checkouts of [Buildbarn Storage](https://github.com/buildbarn/bb-storage),
[Buildbarn Browser](https://github.com/buildbarn/bb-browser) and
[Buildbarn Remote Execution](https://github.com/buildbarn/bb-remote-execution),
respectively. The script assumes that these projects have been built
(`bazel build //...`).

```sh
./run.sh ~/projects/bb-storage ~/projects/bb-browser ~/projects/bb-remote-execution
```

# Using this deployment with Bazel

In addition to [the generic build options](https://github.com/buildbarn/bb-deployments/blob/master/bazelrc),
the following options should be added to `~/.bazelrc`:

```
build:local --config=remote
build:local --jobs=8
build:local --remote_executor=localhost:8980
build:local --remote_instance_name=local
```

Once added, you may perform remote builds against Buildbarn by running
the command below:

```
bazel build --config=local //...
```
