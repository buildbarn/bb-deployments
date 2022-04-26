#!/usr/bin/env bash
# This script executes Bazel inside a docker image to generate repositories
# with a C++ toolchain definition. Those files can then be used when running
# remote execution towards that image.
#
# Example usage: ./extract-bazel-auto-toolchains.sh ubuntu-act-22-04 ghcr.io/catthehacker/ubuntu:act-22.04
set -eEuo pipefail

script_dir="$(dirname "${BASH_SOURCE[0]}")"

bazel_version=$(cat "${script_dir}/../../.bazelversion")
fixture_dir="$(realpath "${script_dir}/extract-bazel-auto-toolchains-fixture")"
output_dir="$1"
docker_image="$2"

mkdir -p "$output_dir"
docker run --rm -v "${fixture_dir}:/work" --workdir /work "$docker_image" /work/doit.sh "$bazel_version" | tar -C "$output_dir" -xz

echo "Files successfully extracted the toolchain to ${output_dir}" 1>&2
