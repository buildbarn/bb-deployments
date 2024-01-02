#!/usr/bin/env bash
# Verifies that the bare deployment works.

set -eux -o pipefail -E

script_dir=$(dirname "${BASH_SOURCE[0]}")
root="$(realpath "$script_dir"/..)"
cd "$root"

abseil_output_base="abseil_output_base"
bare_output="bb-output.txt"

working_directory="$root"/tmp-test-bare
mkdir "$working_directory"
cd "$working_directory"

data=bb-data
mkdir "$data"
bazel run --script_path=run_bare.sh -- //bare "$PWD/$data"
./run_bare.sh 2>"${bare_output}" &
buildbarn_pid=$!

cleanup() {
    EXIT_STATUS=$?
    kill "$buildbarn_pid" || true
    wait "$buildbarn_pid" || true
    if [ "$EXIT_STATUS" -ne "0" ]; then
        cat "$bare_output" || true
    fi
    rm -rf "$data"
    rm -rf "$abseil_output_base"
    rm -rf "$working_directory"
    exit "$EXIT_STATUS"
}
trap cleanup EXIT

# --- Run remote execution ---
bazel --output_base="$abseil_output_base" clean
bazel --output_base="$abseil_output_base" \
    test --color=no --curses=no --config=remote-local --disk_cache= \
    @abseil-hello//:hello_test
# Make sure there are remote executions but no cache hits.
# INFO: 39 processes: 9 internal, 30 remote.
grep -E '^INFO: [0-9]+ processes: .*[0-9]+ remote[.,]' \
    "$abseil_output_base/command.log" \
    | grep -v 'remote cache hit'

# --- Check that we get cache hit even after rebooting the server ---
kill "$buildbarn_pid"
wait "$buildbarn_pid" || true
./run_bare.sh 2>"${bare_output}" &
buildbarn_pid=$!

bazel --output_base="$abseil_output_base" clean
bazel --output_base="$abseil_output_base" \
    test --color=no --curses=no --config=remote-local --disk_cache= \
    @abseil-hello//:hello_test
# Make sure there are remote cache hits but no remote executions.
# INFO: 39 processes: 30 remote cache hit, 9 internal.
grep -E '^INFO: [0-9]+ processes: .*[0-9]+ remote cache hit[.,]' \
    "$abseil_output_base/command.log" \
    | grep -v 'remote[,.]'
