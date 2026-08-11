#!/usr/bin/env bash
set -eu -o pipefail

jb=$1
jsonnetfile=$2
jsonnetfile_lock=$3
out_dir=$4

cp "$jsonnetfile" .
cp "$jsonnetfile_lock" .

"$jb" install
cp -r --dereference vendor/* "$out_dir"
