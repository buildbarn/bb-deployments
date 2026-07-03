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

# This fetches the workflow runs triggered by a specified commit,
# and then prints the Github URL to the runs with at least 1 artifact.
actions_summary_page() {
    repo="$1"; shift
    commit_hash="$1"; shift

    res="$(python3 -c """
import requests

headers = {
    'Accept': 'application/vnd.github+json',
    'X-GitHub-Api-Version': '2026-03-10',
}

workflow_runs = requests.get(
    # https://docs.github.com/en/rest/actions/workflow-runs?apiVersion=2026-03-10#list-workflow-runs-for-a-repository
    url='https://api.github.com/repos/buildbarn/$repo/actions/runs',
    params={
        'head_sha': '$commit_hash',  # Only get the workflow runs for the specified commit
        'event': 'push'
    },
    headers=headers,
)

workflow_runs.raise_for_status()
workflow_runs_json = workflow_runs.json()

if workflow_runs_json['total_count'] > 0:
    for run in workflow_runs_json['workflow_runs']:
        run_id = run['id']
        artifacts = requests.get(
            # https://docs.github.com/en/rest/actions/artifacts?apiVersion=2026-03-10#list-workflow-run-artifacts
            url=f'https://api.github.com/repos/buildbarn/$repo/actions/runs/{run_id}/artifacts',
            headers=headers,
        )
        artifacts.raise_for_status()
        artifacts_json = artifacts.json()
        if artifacts_json['total_count'] > 0:  # Only include the run URL if it has any artifacts
            print(f'https://github.com/buildbarn/$repo/actions/runs/{run_id}')
        """)"
    echo "$res"
}

# Formats a string of Github workflow run URLs to
# a Markdown string with one of the following
# formats (multiline and single-line inputs, respectively):
#
#   [CI artifacts #1](<workflow-run-url-1>), [CI artifacts #2](<workflow-run-url-2>), ...
#
# or
#
#   [CI artifacts](<workflow-run-url>)
#
format_artifact_urls() {
    urls="$1"; shift

    output="$(python3 -c """
urls = '$urls'.splitlines()
urls_count = len(urls)
output = ''
if urls_count > 1:
    for i in range(0, urls_count):
        output += f'[CI artifacts #{i+1}({urls[i]})], '
elif urls_count == 1:
    output = f'[CI artifacts]({urls[0]})'

print(output.strip(', '))
    """)"

    echo "$output"
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
    local artifact_url
    artifact_url=$(actions_summary_page "$repo" "$commit_hash")

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
    local right
    right="${images}$(format_artifact_urls "$artifact_url")"
    local entry="| $left | $right |"
    sed -i "s#| \[$repo\].*#$entry#" README.md
}

update_image_version bb-portal bb-portal
update_image_version bb-remote-execution bb-runner-installer
update_image_version bb-remote-execution bb-scheduler
update_image_version bb-remote-execution bb-worker
update_image_version bb-storage bb-storage

update_version_table bb-portal bb-portal
update_version_table bb-remote-execution bb-runner-installer bb-scheduler bb-worker
update_version_table bb-storage bb-storage
