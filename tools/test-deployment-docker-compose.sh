#!/usr/bin/env bash

# Verifies that the docker-compose deployment works.
set -eux -o pipefail -E

script_dir=$(dirname "${BASH_SOURCE[0]}")
cd "${script_dir}/../docker-compose"

cleanup() {
    EXIT_STATUS=$?
    if [ "$EXIT_STATUS" -ne "0" ]; then
        docker-compose logs
    fi
    docker-compose down --remove-orphans || true
    exit $EXIT_STATUS
}
trap cleanup EXIT

# --- Run remote execution ---
rm -rf volumes/storage-*
./run.sh -d
docker-compose up --wait || true
bazel_command_log="$(bazel info output_base)/command.log"
bazel clean
bazel test --color=no --curses=no --config=remote-ubuntu-22-04 --disk_cache= @abseil-hello//:hello_test
# Make sure there are remote executions but no cache hits.
# INFO: 39 processes: 9 internal, 30 remote.
grep -E '^INFO: [0-9]+ processes: .*[0-9]+ remote[.,]' \
    "$bazel_command_log" \
    | grep -v 'remote cache hit'

# --- Check that we get cache hit even after rebooting the server ---
docker-compose down
docker-compose up -d --force-recreate

bazel clean
bazel test --color=no --curses=no --config=remote-ubuntu-22-04 --disk_cache= @abseil-hello//:hello_test
# Make sure there are remote cache hits but no remote executions.
# INFO: 39 processes: 30 remote cache hit, 9 internal.
grep -E '^INFO: [0-9]+ processes: .*[0-9]+ remote cache hit[.,]' \
    "$bazel_command_log" \
    | grep -v 'remote[.,]'

# --- Check that the hardlinking workers are available ---
bazel clean
bazel test --color=no --curses=no --config=remote-ubuntu-22-04 --remote_instance_name=hardlinking --disk_cache= @abseil-hello//:hello_test
# Make sure there are remote executions but no cache hits.
# INFO: 39 processes: 9 internal, 30 remote.
grep -E '^INFO: [0-9]+ processes: .*[0-9]+ remote[.,]' \
    "$bazel_command_log" \
    | grep -v 'remote cache hit'
