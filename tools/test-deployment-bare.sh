#!/usr/bin/env bash
# Verifies that the bare deployment works.
set -eEuxo pipefail

script_dir=$(dirname "${BASH_SOURCE[0]}")
cd "${script_dir}/.."

mkdir tmp-test-bare
cd "tmp-test-bare"
tmp_to_remove="$(pwd)"
abseil_output_base="abseil_output_base"
bare_output="bb-output.txt"

mkdir bb-data
bazel run --script_path=run_bare.sh -- //bare "$(pwd)/bb-data"
./run_bare.sh 2>"${bare_output}" &
buildbarn_pid=$!

cleanup() {
    EXIT_STATUS=$?
    kill "$buildbarn_pid" || true
    wait "$buildbarn_pid" || true
    if [ "$EXIT_STATUS" -ne "0" ]; then
        cat "$bare_output"
    fi
    rm -rf "$tmp_to_remove"
    exit $EXIT_STATUS
}
trap cleanup EXIT

# --- Run remote execution ---
bazel --output_base="$abseil_output_base" clean
bazel --output_base="$abseil_output_base" test --color=no --curses=no --config=remote-local --disk_cache= @abseil-hello//:hello_test
# Make sure there are remote executions but no cache hits.
# INFO: 39 processes: 9 internal, 30 remote.
cat "${abseil_output_base}/command.log" | grep -E '^INFO: [0-9]+ processes: .*[0-9]+ remote[.,]' | grep -v 'remote cache hit'

# --- Check that we get cache hit even after rebooting the server ---
kill "$buildbarn_pid"
wait "$buildbarn_pid" || true
./run_bare.sh 2>"${bare_output}" &
buildbarn_pid=$!

bazel --output_base="$abseil_output_base" clean
bazel --output_base="$abseil_output_base" test --color=no --curses=no --config=remote-local --disk_cache= @abseil-hello//:hello_test
# Make sure there are remote cache hits but no remote executions.
# INFO: 39 processes: 30 remote cache hit, 9 internal.
cat "${abseil_output_base}/command.log" | grep -E '^INFO: [0-9]+ processes: .*[0-9]+ remote cache hit[.,]' | grep -v 'remote[,.]'
