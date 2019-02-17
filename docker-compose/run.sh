#!/usr/bin/env bash

set -eux

for worker in worker-debian8 worker-ubuntu16-04; do
  sudo rm -rf "${worker}"
  mkdir -m 0777 "${worker}" "${worker}/build"
  mkdir -m 0700 "${worker}/cache"
done

exec docker-compose up
