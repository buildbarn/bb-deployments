# 2023-12-22

* Support Bazel 7
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
