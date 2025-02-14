# 2025-02-19

* Upgrade to Bazel 8 and Go 1.24.0
* Enable round robin option in grpc client
* Add grpc code to metrics replicator
* Add missing label on replicator metrics and unit tests
* Emit additional metrics on replicate blobs and refresh blobs

# 2024-12-18

* Change FUSE mount to not fallback to 'fusermount'
  https://github.com/buildbarn/bb-remote-execution/commit/d03d5e3708ed851f7ec73a92e8ba155a97d88793

# 2024-11-12

* Double the number of KeyLocationMap attempts
* Rename Grafana metric name "old_current_new" to "old_new_current"

# 2024-10-24

* Use more dependencies through modules and avoid a few patches
* Improved TLS Cert handling

# 2024-08-14

* Freshen up Windows Workers

# 2024-07-15

* Make input root population for hardlinking workers run in parallel
* Automatic negotiation of NFSv4 minor version
* Add an NFSv4.1 server
* Better support for Windows filesystem operations

# 2024-06-27

* Better support for windows paths in the filesystem layer
* Update to Bazel 7.2.0 and Go 1.22.4
* JWT: Add a signature generator for Ed25519
* Add support for TLS to HTTP servers
* Build and use multi-architecture container images.

# 2024-03-20

* Rewrite Remote Output Service on top of Google's protocol
* Using macOS Sonoma 14.4 or later is recommended for NFSv4.0
* Remove support for FUSE mounts on macOS
  Use NFS instead.

# 2024-02-28

* Integrate kuberesolver into Buildbarn binaries
  This makes it easier to run Buildbarn on bare metal Kubernetes clusters.
  https://github.com/buildbarn/bb-storage/commit/a4267fc3c5c3a916004c5021fb13bc2bcf214e05
* Delay uploads until output files are closed
  This is needed for asynchronously written core dumps that are captured during execution.
* Add the ability to link to external pages based on RequestMetadata
  New required configuration for bb-browser, the nil values does not work.
    requestMetadataLinksJmespathExpression: '`{}`'

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
