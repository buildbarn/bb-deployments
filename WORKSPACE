workspace(name = "com_github_buildbarn_bb_deployments")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "59d5b42ac315e7eadffa944e86e90c2990110a1c8075f1cd145f487e999d22b3",
    strip_prefix = "rules_docker-0.17.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.17.0/rules_docker-v0.17.0.tar.gz"],
)

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "16e9fca53ed6bd4ff4ad76facc9b7b651a89db1689a2877d6fd7b82aa824e366",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.34.0/rules_go-v0.34.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.34.0/rules_go-v0.34.0.zip",
    ],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "501deb3d5695ab658e82f6f6f549ba681ea3ca2a5fb7911154b5aa45596183fa",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.26.0/bazel-gazelle-v0.26.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.26.0/bazel-gazelle-v0.26.0.tar.gz",
    ],
)

http_archive(
    name = "bazel_skylib",
    sha256 = "f7be3474d42aae265405a592bb7da8e171919d74c16f082a5457840f06054728",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
    ],
)

# gazelle:repository_macro go_dependencies.bzl%go_dependencies
load(":go_dependencies.bzl", "go_dependencies")

go_dependencies()

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.19")

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

http_archive(
    name = "com_google_protobuf",
    sha256 = "ba0650be1b169d24908eeddbe6107f011d8df0da5b1a5a4449a913b10e578faf",
    strip_prefix = "protobuf-3.19.4",
    urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v3.19.4/protobuf-all-3.19.4.tar.gz"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

# Below dependencies are for the example project.

http_archive(
    name = "com_grail_bazel_toolchain",
    canonical_id = "0.6.3",
    sha256 = "da607faed78c4cb5a5637ef74a36fdd2286f85ca5192222c4664efec2d529bb8",
    strip_prefix = "bazel-toolchain-0.6.3",
    url = "https://github.com/grailbio/bazel-toolchain/archive/0.6.3.tar.gz",
)

load("@com_grail_bazel_toolchain//toolchain:rules.bzl", "llvm_toolchain")

llvm_toolchain(
    name = "llvm_toolchain",
    llvm_version = "13.0.0",
)

# C++ rules for Bazel.
http_archive(
    name = "rules_cc",
    sha256 = "fe1e7b1801a63e79eb1b40dc44bf0590117a399e118ac44afd6fa07bf63e9ece",
    strip_prefix = "rules_cc-58f8e026c00a8a20767e3dc669f46ba23bc93bdb",
    urls = ["https://github.com/bazelbuild/rules_cc/archive/58f8e026c00a8a20767e3dc669f46ba23bc93bdb.zip"],
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
    name = "build_bazel_rules_nodejs",
    sha256 = "8f5f192ba02319254aaf2cdcca00ec12eaafeb979a80a1e946773c520ae0a2c9",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/3.7.0/rules_nodejs-3.7.0.tar.gz"],
)

load("@build_bazel_rules_nodejs//:index.bzl", "node_repositories", "npm_install")

node_repositories(
    node_version = "16.4.1",
)

npm_install(
    name = "npm",
    package_json = "@com_github_buildbarn_bb_storage//:package.json",
    package_lock_json = "@com_github_buildbarn_bb_storage//:package-lock.json",
    symlink_node_modules = False,
)

http_archive(
    name = "rules_antlr",
    patches = ["@com_github_buildbarn_go_xdr//:patches/rules_antlr/antlr-4.10.diff"],
    sha256 = "26e6a83c665cf6c1093b628b3a749071322f0f70305d12ede30909695ed85591",
    strip_prefix = "rules_antlr-0.5.0",
    urls = ["https://github.com/marcohu/rules_antlr/archive/0.5.0.tar.gz"],
)

load("@rules_antlr//antlr:repositories.bzl", "rules_antlr_dependencies")

rules_antlr_dependencies("4.10")

load("@com_github_bazelbuild_remote_apis//:repository_rules.bzl", "switched_rules_by_language")

switched_rules_by_language(
    name = "bazel_remote_apis_imports",
    go = True,
)
