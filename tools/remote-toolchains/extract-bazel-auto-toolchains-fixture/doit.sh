#!/usr/bin/env bash

set -eux -o pipefail -E

bazel_version="$1"

curl -L -o /bazel "https://github.com/bazelbuild/bazel/releases/download/${bazel_version}/bazel-${bazel_version}-linux-x86_64"
chmod +x /bazel
/bazel query '@local_config_cc//:all + @local_config_cc_toolchains//:all + @local_config_platform//:all + @local_config_sh//:all' > /dev/null
output_base=$(/bazel info output_base)
tar -C "${output_base}/external" -hcz local_config_cc local_config_cc_toolchains local_config_platform local_config_sh
