#!/usr/bin/env bash
set -eu -o pipefail
# Updates the image version in the Docker Compose and Kubernetes deployments.
#
# Run this script as soon as go.mod has been updated.
#
# The image versions are extracted from `go.mod`, with the date field
# and a hash truncated to seven characters.
# The date separates the day and the time segment with a "T"
# and appends "Z".
#
# Example:
#
#   'go.mod' and 'docker-compose.yml'
#   github.com/buildbarn/bb-browser v0.0.0-20230906070406-881fd822f75e
#   github.com/buildbarn/bb-browser         v0.0.0-20230906 070406 -881fd822f75e
#     browser.image:  ghcr.io/buildbarn/bb-browser:20230906T070406Z-881fd82
#             differences: T, Z and truncated hash.        ^      ^        ^^^^^

get_image_version() {
    repo="$1"
    grep -E "github\.com/buildbarn/${repo}" go.mod \
        | sed 's,.* v0.0.0-\([0-9]\{8\}\)\([0-9]\{6\}\)-\([0-9a-f]\{7\}\)[0-9a-f]\+,\1T\2Z-\3,'
}

update_image_version() {
    new_version="$1"
    image_name="$2"
    sed -i "s,\(image: ghcr\.io/buildbarn/${image_name}:\)\S*,\1${new_version}," \
        docker-compose/docker-compose.yml kubernetes/*.yaml
}

bb_browser_version=$(get_image_version bb-browser)
bb_remote_execution_version=$(get_image_version bb-remote-execution)
bb_storage_version=$(get_image_version bb-storage)

update_image_version "$bb_browser_version" bb-browser
update_image_version "$bb_remote_execution_version" bb-runner-installer
update_image_version "$bb_remote_execution_version" bb-scheduler
update_image_version "$bb_remote_execution_version" bb-worker
update_image_version "$bb_storage_version" bb-storage
