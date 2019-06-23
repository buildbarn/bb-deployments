#!/usr/bin/env bash

set -eux

worker="worker-ubuntu16-04"

sudo rm -rf "${worker}"
mkdir -m 0777 "${worker}" "${worker}/build"
mkdir -m 0700 "${worker}/cache"

exec docker-compose up
