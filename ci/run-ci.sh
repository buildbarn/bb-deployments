#!/bin/bash

worker="worker-ubuntu16-04"

# From https://github.com/bazelbuild/bazel/blob/master/tools/bash/runfiles/runfiles.bash:
set -uo pipefail; f=bazel_tools/tools/bash/runfiles/runfiles.bash
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
  source "$0.runfiles/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=; set -e

cleanup() {
  status=$?
  rm -rf "${worker}"
  docker-compose -f $(rlocation "com_github_buildbarn_bb_deployments/ci/docker-compose.yml") down
  exit $status
}
trap cleanup 0

set -x
set +u

export CURWD=$(pwd)

mkdir -pm 0777 "${worker}" "${worker}/build"
mkdir -m 0700 "${worker}/cache"

docker-compose -f $(rlocation "com_github_buildbarn_bb_deployments/ci/docker-compose.yml") up -d && \
docker-compose -f $(rlocation "com_github_buildbarn_bb_deployments/ci/docker-compose-build.yml") run --rm builder && \
if test "${BUILDKITE_BRANCH}" = "master"; then
  docker-compose -f $(rlocation "com_github_buildbarn_bb_deployments/ci/docker-compose-build.yml") run --rm imager
fi
