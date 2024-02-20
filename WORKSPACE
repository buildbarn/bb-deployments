workspace(name = "com_github_buildbarn_bb_deployments")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_pkg",
    sha256 = "8f9ee2dc10c1ae514ee599a8b42ed99fa262b757058f65ad3c384289ff70c4b8",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.9.1/rules_pkg-0.9.1.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.9.1/rules_pkg-0.9.1.tar.gz",
    ],
)

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.25.0/rules_docker-v0.25.0.tar.gz"],
)

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "91585017debb61982f7054c9688857a2ad1fd823fc3f9cb05048b0025c47d023",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.42.0/rules_go-v0.42.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.42.0/rules_go-v0.42.0.zip",
    ],
)

# bb-storage is downloaded to separately to apply patches to gazelle.
# Then the real `com_github_buildbarn_bb_storage` is downloaded through `go_dependencies.bzl`.
http_archive(
    name = "com_github_buildbarn_bb_storage_patches",
    patch_cmds = [
        # Delete everything except the patches directory.
        "rm -r $(ls -A | grep -v patches)",
        "touch WORKSPACE",
        "touch BUILD.bazel",
    ],
    sha256 = "65882110a7f90518b58d8794d611a8465b1da38498205bd7aaffd63304803a7c",
    strip_prefix = "bb-storage-068d214ed6a3c10ff405e3d72d9a27710b0256cc/",
    urls = [
        "https://github.com/buildbarn/bb-storage/archive/068d214ed6a3c10ff405e3d72d9a27710b0256cc.zip",
    ],
)

http_archive(
    name = "bazel_gazelle",
    patches = [
        "@com_github_buildbarn_bb_storage_patches//:patches/bazel_gazelle/dont-flatten-srcs.diff",
    ],
    sha256 = "b7387f72efb59f876e4daae42f1d3912d0d45563eac7cb23d1de0b094ab588cf",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.34.0/bazel-gazelle-v0.34.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.34.0/bazel-gazelle-v0.34.0.tar.gz",
    ],
)

# gazelle:repository_macro go_dependencies.bzl%go_dependencies
load(":go_dependencies.bzl", "go_dependencies")

go_dependencies()

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.21.5")

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

http_archive(
    name = "com_google_protobuf",
    integrity = "sha256-m9h7goDvcg0yQFFPiE5WpxLyIY8NaTtIBQyDYCiUCkI=",
    strip_prefix = "protobuf-25.1",
    urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v25.1/protobuf-25.1.tar.gz"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

# # Dependencies below are for the example project.

# C++ rules for Bazel.

http_archive(
    name = "rules_cc",
    sha256 = "2037875b9a4456dce4a79d112a8ae885bbc4aad968e6587dca6e64f3a0900cdf",
    strip_prefix = "rules_cc-0.0.9",
    urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.9/rules_cc-0.0.9.tar.gz"],
)

http_archive(
    name = "toolchains_llvm",
    canonical_id = "0.7.2",
    sha256 = "ea7d247dd4a0058c008a6e8fa0855a69d57b0cb500271c7b48c1a28512608ecd",
    strip_prefix = "toolchains_llvm-0.7.2",
    url = "https://github.com/bazel-contrib/toolchains_llvm/archive/0.7.2.tar.gz",
)

load("@toolchains_llvm//toolchain:rules.bzl", "llvm_toolchain")

llvm_toolchain(
    name = "llvm_toolchain",
    llvm_version = "14.0.0",
)

# Register the auto configured rules_cc toolchain for local execution.
load("@rules_cc//cc:repositories.bzl", "rules_cc_dependencies", "rules_cc_toolchains")

rules_cc_dependencies()

rules_cc_toolchains()

# Import toolchain repositories for remote executions, but register the
# toolchains using --extra_toolchains on the command line to get precedence.
local_repository(
    name = "remote_config_cc",
    path = "tools/remote-toolchains/ubuntu-act-22-04/local_config_cc",
)

local_repository(
    name = "remote_config_sh",
    path = "tools/remote-toolchains/ubuntu-act-22-04/local_config_sh",
)

# abseil-cpp
http_archive(
    name = "com_google_absl",
    sha256 = "af7a1c42dc68c966e2451c3f2c6c9ff7b8b590d590f6078ed912dcb215a9f062",
    strip_prefix = "abseil-cpp-731689ffc2ad7bb95cc86b5b6160dbe7858f27a0",
    urls = ["https://github.com/abseil/abseil-cpp/archive/731689ffc2ad7bb95cc86b5b6160dbe7858f27a0.zip"],
)

# Google Test
http_archive(
    name = "com_google_googletest",
    sha256 = "7e434199a53a71fd0f6ddd6d605e1bdcd65edbc2cefad8fb07a18347927f41d0",
    strip_prefix = "googletest-c144d78f8295da3dbae3ad2d5fe66a9a42f8ce74",
    urls = ["https://github.com/google/googletest/archive/c144d78f8295da3dbae3ad2d5fe66a9a42f8ce74.zip"],
)

http_archive(
    name = "abseil-hello",
    sha256 = "e676640e69e210636de795f571237bec09a9ad9af6e441bf56f0d193cfe1c9fc",
    strip_prefix = "abseil-hello-b4803b41ab3d58c503265148e5a7d3fd2a8e46d3/bazel-hello",
    urls = ["https://github.com/abseil/abseil-hello/archive/b4803b41ab3d58c503265148e5a7d3fd2a8e46d3.zip"],
)

http_archive(
    name = "io_bazel_rules_jsonnet",
    sha256 = "d20270872ba8d4c108edecc9581e2bb7f320afab71f8caa2f6394b5202e8a2c3",
    strip_prefix = "rules_jsonnet-0.4.0",
    urls = ["https://github.com/bazelbuild/rules_jsonnet/archive/0.4.0.tar.gz"],
)

load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_repositories")

jsonnet_repositories()

load("@google_jsonnet_go//bazel:repositories.bzl", "jsonnet_go_repositories")

jsonnet_go_repositories()

load("@google_jsonnet_go//bazel:deps.bzl", "jsonnet_go_dependencies")

jsonnet_go_dependencies()

http_archive(
    name = "com_github_grafana_grafonnet_lib",
    build_file_content = """
load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_library")

jsonnet_library(
    name = "grafonnet",
    srcs = glob(["grafonnet/*.libsonnet"]),
    imports = ["."],
    visibility = ["//visibility:public"],
)
""",
    sha256 = "ef8d75ab8633024f0a214f61e28ca8a5fe384467ce1151587eb812ddf7181e76",
    strip_prefix = "grafonnet-lib-04f3e87e2d524c7aba936aae525f388290d94291",
    urls = ["https://github.com/grafana/grafonnet-lib/archive/04f3e87e2d524c7aba936aae525f388290d94291.tar.gz"],
)

http_archive(
    name = "com_github_twbs_bootstrap",
    build_file_content = """exports_files(["css/bootstrap.min.css", "js/bootstrap.min.js"])""",
    sha256 = "395342b2974e3350560e65752d36aab6573652b11cc6cb5ef79a2e5e83ad64b1",
    strip_prefix = "bootstrap-5.1.0-dist",
    urls = ["https://github.com/twbs/bootstrap/releases/download/v5.1.0/bootstrap-5.1.0-dist.zip"],
)

http_archive(
    name = "aspect_rules_js",
    sha256 = "76a04ef2120ee00231d85d1ff012ede23963733339ad8db81f590791a031f643",
    strip_prefix = "rules_js-1.34.1",
    url = "https://github.com/aspect-build/rules_js/releases/download/v1.34.1/rules_js-v1.34.1.tar.gz",
)

load("@aspect_rules_js//js:repositories.bzl", "rules_js_dependencies")

rules_js_dependencies()

load("@rules_nodejs//nodejs:repositories.bzl", "DEFAULT_NODE_VERSION", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "nodejs",
    node_version = DEFAULT_NODE_VERSION,
)

load("@aspect_rules_js//npm:npm_import.bzl", "npm_translate_lock")

npm_translate_lock(
    name = "npm",
    pnpm_lock = "@com_github_buildbarn_bb_storage//:pnpm-lock.yaml",
)

load("@npm//:repositories.bzl", "npm_repositories")

npm_repositories()

http_archive(
    name = "rules_antlr",
    patches = ["@com_github_buildbarn_go_xdr//:patches/rules_antlr/antlr-4.10.diff"],
    sha256 = "26e6a83c665cf6c1093b628b3a749071322f0f70305d12ede30909695ed85591",
    strip_prefix = "rules_antlr-0.5.0",
    urls = ["https://github.com/marcohu/rules_antlr/archive/0.5.0.tar.gz"],
)

load("@rules_antlr//antlr:repositories.bzl", "rules_antlr_dependencies")

rules_antlr_dependencies("4.10")

http_archive(
    name = "io_opentelemetry_proto",
    build_file_content = """
proto_library(
    name = "common_proto",
    srcs = ["opentelemetry/proto/common/v1/common.proto"],
    visibility = ["//visibility:public"],
)
""",
    sha256 = "464bc2b348e674a1a03142e403cbccb01be8655b6de0f8bfe733ea31fcd421be",
    strip_prefix = "opentelemetry-proto-0.19.0",
    urls = ["https://github.com/open-telemetry/opentelemetry-proto/archive/refs/tags/v0.19.0.tar.gz"],
)

http_archive(
    name = "googleapis",
    sha256 = "361e26593b881e70286a28065859c941e25b96f9c48ba91127293d0a881152d6",
    strip_prefix = "googleapis-a3770599794a8d319286df96f03343b6cd0e7f4f",
    urls = ["https://github.com/googleapis/googleapis/archive/a3770599794a8d319286df96f03343b6cd0e7f4f.zip"],
)

load("@googleapis//:repository_rules.bzl", "switched_rules_by_language")

switched_rules_by_language(
    name = "com_google_googleapis_imports",
)
