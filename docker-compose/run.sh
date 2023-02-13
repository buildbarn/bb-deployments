#!/usr/bin/env bash
set -eu

worker_fuse="worker-fuse-ubuntu22-04"
worker_hardlinking="worker-hardlinking-ubuntu22-04"
fuse_dir_to_unmount="volumes/${worker_fuse}/build"

set -x
sudo fusermount -u "$fuse_dir_to_unmount" && sleep 1 || true
sudo rm -rf bb "volumes/${worker_fuse}" "volumes/${worker_hardlinking}"
mkdir -p volumes
mkdir -m 0777 "volumes/${worker_fuse}" "volumes/${worker_fuse}"/{build,cas,cas/persistent_state}
mkdir -m 0777 "volumes/${worker_hardlinking}" "volumes/${worker_hardlinking}"/{build,cas,cas/persistent_state}
mkdir -m 0700 "volumes/${worker_fuse}/cache" "volumes/${worker_hardlinking}/cache"
mkdir -m 0700 -p volumes/storage-{ac,cas}-{0,1}/persistent_state
set +x

cleanup() {
    EXIT_STATUS=$?
    set -x
    sudo fusermount -u "$fuse_dir_to_unmount" || true
    exit $EXIT_STATUS
}

# If no arguments have been given, automatically unmount worker FUSE mount.
# This avoids annoying problems when trying to cleanup after a simple test run of Buildbarn.
if [ $# -eq 0 ]; then
    echo "Registering automatic unmount for $fuse_dir_to_unmount"
    trap cleanup EXIT
else
    echo "When finished, manually unmount $fuse_dir_to_unmount"
fi
docker-compose up "$@"
