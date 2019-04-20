#!/usr/bin/env bash

set -eu

if [ $# -ne 3 ]; then
  echo "usage: storage_srcdir browser_srcdir remote_execution_srcdir" >&2
  exit 1
fi

STORAGE_SRC="${1}"
BROWSER_SRC="${2}"
REMOTE_EXECUTION_SRC="${3}"

cd "$(dirname "$0")"

# Golang architecture of the current system.
ARCH="$(uname | tr '[A-Z]' '[a-z]')_amd64_pure_stripped"

CURWD="$(pwd)"
trap 'kill $(jobs -p)' EXIT TERM INT

# Clean up data from previous run.
rm -f runner
mkdir -p build cache storage-ac storage-cas

# Launch storage, browser, scheduler, worker and runner.
"${STORAGE_SRC}/bazel-bin/cmd/bb_storage/${ARCH}/bb_storage" \
    -allow-ac-updates-for-instance=local \
    -blobstore-config blobstore-storage.conf \
    -scheduler 'local|localhost:8981' \
    -web.listen-address localhost:7980 &
(cd "${BROWSER_SRC}/cmd/bb_browser" &&
 exec "${BROWSER_SRC}/bazel-bin/cmd/bb_browser/${ARCH}/bb_browser" \
    -blobstore-config "${CURWD}/blobstore-storage-clients.conf" \
    -web.listen-address localhost:7984) &
"${REMOTE_EXECUTION_SRC}/bazel-bin/cmd/bb_scheduler/${ARCH}/bb_scheduler" \
    -web.listen-address localhost:7981 &
"${REMOTE_EXECUTION_SRC}/bazel-bin/cmd/bb_worker/${ARCH}/bb_worker" \
    -blobstore-config blobstore-storage-clients.conf \
    -browser-url http://localhost:7984/ \
    -build-directory build \
    -cache-directory cache \
    -concurrency 4 \
    -runner unix://runner \
    -scheduler localhost:8981 \
    -web.listen-address localhost:7985 &
"${REMOTE_EXECUTION_SRC}/bazel-bin/cmd/bb_runner/${ARCH}/bb_runner" \
    -build-directory build \
    -listen-path runner &

wait
