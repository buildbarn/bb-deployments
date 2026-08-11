#!/usr/bin/env bash
set -eu -o pipefail

jsonnet=$1; shift
out_dir=$1; shift
dashboards_file=$1; shift

cp --dereference "$dashboards_file" dashboards.libsonnet
"$jsonnet" "$@" -m "$out_dir" dashboards.libsonnet
