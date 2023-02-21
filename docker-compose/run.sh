#!/usr/bin/env bash
set -eux

worker="worker-ubuntu22-04"

sudo rm -rf volumes/bb "volumes/${worker}"
mkdir -m 0700 -p volumes
mkdir -m 0777 "volumes/${worker}" "volumes/${worker}/build"
mkdir -m 0700 "volumes/${worker}/cache"
mkdir -m 0700 -p volumes/storage-{ac,cas}-{0,1}/persistent_state

exec docker-compose up "$@"
