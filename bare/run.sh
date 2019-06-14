#!/usr/bin/env bash

set -eu

if [ $# -ne 4 ]; then
  echo "usage: storage_srcdir browser_srcdir remote_execution_srcdir event_service_srcdir" >&2
  exit 1
fi

STORAGE_SRC="${1}"
BROWSER_SRC="${2}"
REMOTE_EXECUTION_SRC="${3}"
EVENT_SERVICE_SRC="${4}"

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
    "${CURWD}/config/bb-storage.json" &
(cd "${BROWSER_SRC}/cmd/bb_browser" &&
  exec "${BROWSER_SRC}/bazel-bin/cmd/bb_browser/${ARCH}/bb_browser" \
      "${CURWD}/config/bb-browser.json") &
"${EVENT_SERVICE_SRC}/bazel-bin/cmd/bb_event_service/${ARCH}/bb_event_service" \
    "${CURWD}/config/bb-event-service.json" &
"${REMOTE_EXECUTION_SRC}/bazel-bin/cmd/bb_scheduler/${ARCH}/bb_scheduler" \
    "${CURWD}/config/bb-scheduler.json" &
"${REMOTE_EXECUTION_SRC}/bazel-bin/cmd/bb_worker/${ARCH}/bb_worker" \
    "${CURWD}/config/bb-worker.json" &
"${REMOTE_EXECUTION_SRC}/bazel-bin/cmd/bb_runner/${ARCH}/bb_runner" \
    "${CURWD}/config/bb-runner.json" &

wait
