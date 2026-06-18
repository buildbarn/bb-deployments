#!/usr/bin/env bash

set -eu -o pipefail
shopt -s inherit_errexit

# NB: We have subshells that want to exit the whole script.
# As we want to capture their output but also verify exit conditions inside.
set -E
EXIT_FROM_SUBSHELL=77 # Arbitrary but uncommon, there is a risk of conflicts with other valid exit codes.
trap '[ "$?" -ne $EXIT_FROM_SUBSHELL ] || exit $EXIT_FROM_SUBSHELL' ERR

# # Updates the image version in the Docker Compose and Kubernetes deployments.
#
# Run this script after updating MODULE.bazel.
#
# The image versions are constructed using `MODULE.bazel` and Github.
# The first seven characters from the commit hash in `MODULE.bazel`
# and the commit timestamp (any non-alphanumeric characters excluded)
# from Github are combined to get the image version tag.
#
# Example:
#
#   Commit hash (MODULE.bazel): d0c6f2633bb9e199fc7285687cdd677660dc688c
#   Timestamp (Github API):     2026-03-26T15:15:18Z - parsed from https://api.github.com/repos/buildbarn/bb-storage/commits/d0c6f2633bb9e199fc7285687cdd677660dc688c
#   Constructed image version:  20260326T151518Z-d0c6f26

get_override_stanza () {
    local target_remote="$1"; shift

    awk -v target="remote = \"$target_remote\"" '
    /^git_override\(/ {
        is_in_block = 1
        block = $0
        is_target_found = 0
        next
    }
    is_in_block {
        # Add current line to block
        block = block "\n" $0

        # Check if the current line contains our target variable
        if ($0 ~ target) {
            is_target_found = 1
        }

        # Check for the closing parenthesis of the stanza
        if ($0 ~ /^\)[ \t]*$/) {
            is_in_block = 0
            if (is_target_found) {
                print block
            }
        }
    }
    ' "MODULE.bazel"
}

get_timestamp_from_github_response() {
    input="$1"; shift
    match=$(grep -Em 1 -A4 '^    \"committer\": {' <<< "$input" \
    | grep -E "^      \"date\":")
    echo "${match:(-22)}" | tr -cd '[:alnum:]'
}

curl_version() {
    url=$1; shift
    # Manual error handling for curl to write a shorter error message.
    local -
    set +e

    # https://docs.github.com/en/rest/commits/commits?apiVersion=2026-03-10#get-a-commit
    commit_response=$(curl --silent --fail -L \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2026-03-10" \
        "$url")
    exit_code=$?
    if [[ "$exit_code" != 0 ]]; then
        echo >&2 "Failed to fetch $url"
        exit $EXIT_FROM_SUBSHELL
    fi

    echo "$commit_response"
}

get_image_version() {
    repo="$1"; shift
    hash_full=$(get_full_git_commit_hash "$repo")
    if [[ -z "$hash_full" ]]; then
        echo >&2 "Failed to retrieve commit hash in MODULE.bazel for repo $repo"
        exit 1
    fi
    hash_short="${hash_full::7}"
    commit_response="$(curl_version "https://api.github.com/repos/buildbarn/$repo/commits/$hash_full")"

    timestamp=$(get_timestamp_from_github_response "$commit_response")
    echo "$timestamp-$hash_short"
}

get_full_git_commit_hash() {
    repo="$1"; shift
    remote="https://github.com/buildbarn/$repo.git"

    get_override_stanza "$remote" \
    | grep -E "^[[:space:]]*commit = \"" \
    | grep -E --only-matching "[0-9a-f]{40}"
}

actions_summary_page() {
    checks_url=$1; shift

    ### The result is a nested span within a `href` tag.
    # So we capture each href tag as we pass them,
    # and when we see the needle "on: push"
    # we can print the last href tag we encountered.
    res="$(curl -s "$checks_url" | awk '
    {
        if ($0 ~/<a href/)
            { link=$0 }
            if ($0 ~/on: push/) {
                split(link, parts, " ");
                href=parts[2]
                split(href, parts, "\"");
                suffix=parts[2]
                print("https://github.com" suffix)
            }
        }
    ')"
    echo "$res"
}

update_image_version() {
    # Update kubernetes and docker-compose image versions.
    local repo="$1"; shift
    local image_name="$1"; shift

    local image_version
    image_version=$(get_image_version "$repo")

    sed -i "s#\(ghcr\.io/buildbarn/$image_name:\)[0-9tzTZ]*-[0-9a-f]*#\1$image_version#g" \
        docker-compose/docker-compose.yml kubernetes/*.yaml
}

update_version_table() {
    # Update the version table in the README.
    local repo="$1"; shift
    # images are left as arguments;

    local image_version
    image_version=$(get_image_version "$repo")
    local timestamp
    # shellcheck disable=SC2001
    timestamp=$(echo "$image_version" \
        | sed 's#\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)T\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)Z.*#\1-\2-\3 \4:\5:\6#')
    timestamp="$timestamp UTC"
    local commit_hash
    commit_hash=$(get_full_git_commit_hash "$repo")
    local short_commit_hash="${commit_hash:0:10}"
    local github_project_url="https://github.com/buildbarn/$repo"
    local checks_url="$github_project_url/commit/$commit_hash/checks"
    local artifact_url
    artifact_url=$(actions_summary_page "$checks_url")

    local git_log_stem="https://github.com/buildbarn/$repo/commits"
    local commit_url="$git_log_stem/$commit_hash"

    # TODO: move 'UTC' into the timestamp variable.
    local images=""
    for image_name in "$@"; do
        image_timestamp=$image_version
        local image_qualifier="ghcr.io/buildbarn/$image_name:$image_timestamp"
        local image_url="https://$image_qualifier"
        images="${images}[$image_qualifier]($image_url)<br/>"
    done

    local left="[$repo]($github_project_url) [\`$short_commit_hash\`]($commit_url)<br/>$timestamp"
    local right="${images}[CI artifacts]($artifact_url)"
    local entry="| $left | $right |"
    sed -i "s#| \[$repo\].*#$entry#" README.md
}

update_image_version bb-browser bb-browser
update_image_version bb-remote-execution bb-runner-installer
update_image_version bb-remote-execution bb-scheduler
update_image_version bb-remote-execution bb-worker
update_image_version bb-storage bb-storage

update_version_table bb-browser bb-browser
update_version_table bb-remote-execution bb-runner-installer bb-scheduler bb-worker
update_version_table bb-storage bb-storage
