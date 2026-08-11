#!/usr/bin/env bash
set -eu -o pipefail

jsonnet=$1
jsonnet_imports=$2
out_dir=$3
dashboards_file=$4

cp --dereference $dashboards_file dashboards.libsonnet
$jsonnet $jsonnet_imports -m $out_dir dashboards.libsonnet
