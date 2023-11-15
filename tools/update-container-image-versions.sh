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
    repo="$1"; shift
    grep -E "github\.com/buildbarn/${repo}" go.mod \
        | sed 's#.* v0.0.0-\([0-9]\{8\}\)\([0-9]\{6\}\)-\([0-9a-f]\{7\}\)[0-9a-f]\+#\1T\2Z-\3#'
}

get_full_git_commit_hash() {
    repo="$1"; shift
    # Reuse the same sed expression as in get_image_version.
    short_commit_hash=$(grep -E "github\.com/buildbarn/${repo}" go.mod \
        | sed 's#.* v0.0.0-\([0-9]\{8\}\)\([0-9]\{6\}\)-\([0-9a-f]\+\)#\3#')
    # Let GitHub resolve the full commit hash.
    curl "https://github.com/buildbarn/$repo/commit/$short_commit_hash" \
        | grep '<meta property="og:url" content="' \
        | sed 's#.*<meta property="og:url" content="/buildbarn/'"$repo"'/commit/\([0-9a-f]*\)" />.*#\1#'
}

update_image_version() {
    repo="$1"; shift
    image_name="$1"; shift

    image_version=$(get_image_version "$repo")
    timestamp=$(echo "$image_version" | sed 's#\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)T\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)Z.*#\1-\2-\3 \4:\5:\6#')
    commit_hash=$(get_full_git_commit_hash "$repo")

    # Replace image version.
    sed -i "s#\(ghcr\.io/buildbarn/${image_name}:\)[0-9tzTZ]*-[0-9a-f]*#\1${image_version}#g" \
        README.md docker-compose/docker-compose.yml kubernetes/*.yaml

    # Replace timestamp and CI Build link.
    sed -i \
        -e "s#^\(| ${image_name} .*| \)\([^|]* UTC |\)#\1${timestamp} UTC |#" \
        -e "s#| [^|]*/buildbarn/${repo}/commit/[0-9a-f]*/checks#| [\`${commit_hash}\`](https://github.com/buildbarn/${repo}/commit/${commit_hash}/checks#" \
        README.md
}

update_image_version bb-browser bb-browser
update_image_version bb-remote-execution bb-runner-installer
update_image_version bb-remote-execution bb-scheduler
update_image_version bb-remote-execution bb-worker
update_image_version bb-storage bb-storage
