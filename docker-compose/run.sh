#!/usr/bin/env bash

set -eux

worker_volume="buildbarn-worker-ubuntu16-04"
tini_volume="buildbarn-tini"

docker volume rm "${worker_volume}" || true
docker volume rm "${tini_volume}" || true

docker volume create "${worker_volume}"
docker run --rm \
  -v "${worker_volume}:/worker" \
  busybox:latest \
  /bin/sh -c 'mkdir -p /worker/build /worker/cache'

exec docker-compose up
