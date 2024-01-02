#!/usr/bin/env bash

set -eu -o pipefail -E

diff_config() {
    k8s_config="$1"; shift
    docker_config="$1"; shift

    # Allow diffs, i.e. exit code 1 from 'git-diff'.
    git diff --no-index "$k8s_config" "$docker_config" || [ $? == 1 ]
}

diff_config {kubernetes,docker-compose}/config/browser.jsonnet
diff_config {kubernetes,docker-compose}/config/common.libsonnet
diff_config {kubernetes,docker-compose}/config/frontend.jsonnet
diff_config {kubernetes,docker-compose}/config/runner-ubuntu22-04.jsonnet
diff_config {kubernetes,docker-compose}/config/scheduler.jsonnet
diff_config {kubernetes,docker-compose}/config/storage.jsonnet

diff_config kubernetes/config/worker-ubuntu22-04.jsonnet docker-compose/config/worker-hardlinking-ubuntu22-04.jsonnet
