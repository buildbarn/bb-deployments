#!/usr/bin/env bash

set -eu -o pipefail -E

# # Updates the image version in the Docker Compose and Kubernetes deployments.
#
# Run this script after updating go.mod
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
    grep -E "github\.com/buildbarn/$repo" go.mod \
        | sed 's#.* v0.0.0-\([0-9]\{8\}\)\([0-9]\{6\}\)-\([0-9a-f]\{7\}\)[0-9a-f]\+#\1T\2Z-\3#'
}

get_full_git_commit_hash() {
    repo="$1"; shift
    # Reuse the same sed expression as in get_image_version.
    short_commit_hash=$(grep -E "github\.com/buildbarn/$repo" go.mod \
        | sed 's#.* v0.0.0-\([0-9]\{8\}\)\([0-9]\{6\}\)-\([0-9a-f]\+\)#\3#')
    # Let GitHub resolve the full commit hash.
    curl -s "https://github.com/buildbarn/$repo/commit/$short_commit_hash" \
        | grep '<meta property="og:url" content="' \
        | sed 's#.*<meta property="og:url" content="/buildbarn/'"$repo"'/commit/\([0-9a-f]*\)" />.*#\1#'
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

check_module_overrides() {
    # # Check that the git overrides in MODULE.bazel use the expected versions.
    # We expect the following stanza:
    #
    #   git_override(
    #        module_name = "com_github_buildbarn_bb_storage",
    #        commit = "3f5e30c53d7b52036eb758a63bc98e706f5d4d5c",
    #        remote = "https://github.com/buildbarn/bb-storage.git",
    #   )

    repo="$1"; shift

    commit_hash=$(get_full_git_commit_hash "$repo")
    remote=https://github.com/buildbarn/"$repo".git

    override_stanza="$(grep -B3 -A1 "$remote" MODULE.bazel)"
    echo "$override_stanza" | grep -q "$commit_hash" || {
        echo >&2 "Error: Did not find the expected module version override for $repo."
        echo "Found: $override_stanza"
        echo "Expected: commit = \"$commit_hash\","
        exit 1
    }
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

check_module_overrides bb-browser
check_module_overrides bb-storage
check_module_overrides bb-remote-execution
