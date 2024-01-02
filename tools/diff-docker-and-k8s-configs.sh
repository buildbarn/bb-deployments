#!/usr/bin/env bash

set -eu -o pipefail -E

function diff_config() {
    k8s_config="$1"
    docker_config="$2"
    # Allow diffs, i.e. exit code 1 from git-diff.
    grep -E '^(    |$)' "$k8s_config" \
        | cut -c5- \
        | (git diff --no-index - "$docker_config" || [ $? == 1 ])
}

diff_config kubernetes/config/browser.yaml            docker-compose/config/browser.jsonnet
diff_config kubernetes/config/common.yaml             docker-compose/config/common.libsonnet
diff_config kubernetes/config/frontend.yaml           docker-compose/config/frontend.jsonnet
diff_config kubernetes/config/runner-ubuntu22-04.yaml docker-compose/config/runner-ubuntu22-04.jsonnet
diff_config kubernetes/config/scheduler.yaml          docker-compose/config/scheduler.jsonnet
diff_config kubernetes/config/storage.yaml            docker-compose/config/storage.jsonnet
diff_config kubernetes/config/worker-ubuntu22-04.yaml docker-compose/config/worker-hardlinking-ubuntu22-04.jsonnet
