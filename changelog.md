# 2024-02-28

* Integrate kuberesolver into Buildbarn binaries
  This makes it easier to run Buildbarn on bare metal Kubernetes clusters.
  https://github.com/buildbarn/bb-storage/commit/a4267fc3c5c3a916004c5021fb13bc2bcf214e05
* Delay uploads until output files are closed
  This is needed for asynchronously written core dumps that are captured during execution.

# 2024-01-29

* Support capturing server logs
  This can be used to collect core dumps for crashed actions.
  https://github.com/buildbarn/bb-remote-execution/commit/fe4cf5d42613d9b44be4ef969353fb1212222c73
* Improve the bb-browser's performance by using REv2 Directory messages instead
  of trees
* Change the bb_clientd code snippet to a button.

# 2023-12-22

* bb-deployment supports Bazel 7
* Improved readiness checks for FUSE/NFSv4 runners, better error handling
* Support uploading output directories as Directory Messages
  For more background see https://github.com/bazelbuild/remote-apis/pull/258
  and the main change: https://github.com/buildbarn/bb-remote-execution/commit/f9ea0294c9a36683d06aef1840ba39c2eaccfb68
  • buildbarn/bb-storage@068d214
  • buildbarn/bb-remote-execution@f9ea029
  • buildbarn/bb-remote-execution@4b3a11b
  • buildbarn/bb-clientd@c348521
* Initial support for mount calls in the Buildbarn 'Directory' struct, with a patched golang/x/sys

# 2023-12-05

* ReferenceExpandingBlobAccess: Add support for CAS references

# 2023-11-15

* JWT: Enable reading a JSON Web Key set from a file
