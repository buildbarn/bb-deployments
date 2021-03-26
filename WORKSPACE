workspace(name = "com_github_buildbarn_bb_deployments")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "14ac30773fdb393ddec90e158c9ec7ebb3f8a4fd533ec2abbfd8789ad81a284b",
    strip_prefix = "rules_docker-0.12.1",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.12.1/rules_docker-v0.12.1.tar.gz"],
)

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "142dd33e38b563605f0d20e89d9ef9eda0fc3cb539a14be1bdb1350de2eda659",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.22.2/rules_go-v0.22.2.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.22.2/rules_go-v0.22.2.tar.gz",
    ],
)

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

http_archive(
    name = "bazel_gazelle",
    sha256 = "d8c45ee70ec39a57e7a05e5027c32b1576cc7f16d9dd37135b0eddde45cf1b10",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/bazel-gazelle/releases/download/v0.20.0/bazel-gazelle-v0.20.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.20.0/bazel-gazelle-v0.20.0.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")

gazelle_dependencies()

http_archive(
    name = "com_google_protobuf",
    sha256 = "761bfffc7d53cd01514fa237ca0d3aba5a3cfd8832a71808c0ccc447174fd0da",
    strip_prefix = "protobuf-3.11.1",
    urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v3.11.1/protobuf-all-3.11.1.tar.gz"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

# Below dependencies are for the example project.

# abseil-cpp
http_archive(
    name = "com_google_absl",
    sha256 = "8400c511d64eb4d26f92c5ec72535ebd0f843067515244e8b50817b0786427f9",
    strip_prefix = "abseil-cpp-c512f118dde6ffd51cb7d8ac8804bbaf4d266c3a",
    urls = ["https://github.com/abseil/abseil-cpp/archive/c512f118dde6ffd51cb7d8ac8804bbaf4d266c3a.zip"],
)

# Google Test
http_archive(
    name = "com_google_googletest",
    sha256 = "7c7709af5d0c3c2514674261f9fc321b3f1099a2c57f13d0e56187d193c07e81",
    strip_prefix = "googletest-10b1902d893ea8cc43c69541d70868f91af3646b",
    urls = ["https://github.com/google/googletest/archive/10b1902d893ea8cc43c69541d70868f91af3646b.zip"],
)

# C++ rules for Bazel.
http_archive(
    name = "rules_cc",
    sha256 = "954b7a3efc8752da957ae193a13b9133da227bdacf5ceb111f2e11264f7e8c95",
    strip_prefix = "rules_cc-9e10b8a6db775b1ecd358d8ddd3dab379a2c29a5",
    urls = ["https://github.com/bazelbuild/rules_cc/archive/9e10b8a6db775b1ecd358d8ddd3dab379a2c29a5.zip"],
)

http_archive(
    name = "bazel_toolchains",
    sha256 = "1adf5db506a7e3c465a26988514cfc3971af6d5b3c2218925cd6e71ee443fc3f",
    strip_prefix = "bazel-toolchains-4.0.0",
    urls = [
        "https://github.com/bazelbuild/bazel-toolchains/releases/download/4.0.0/bazel-toolchains-4.0.0.tar.gz",
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-toolchains/archive/4.0.0.tar.gz",
    ],
)

load("@bazel_toolchains//rules:rbe_repo.bzl", "rbe_autoconfig")

rbe_autoconfig(name = "rbe_default")

http_archive(
    name = "abseil-hello",
    sha256 = "e676640e69e210636de795f571237bec09a9ad9af6e441bf56f0d193cfe1c9fc",
    strip_prefix = "abseil-hello-b4803b41ab3d58c503265148e5a7d3fd2a8e46d3/bazel-hello",
    urls = ["https://github.com/abseil/abseil-hello/archive/b4803b41ab3d58c503265148e5a7d3fd2a8e46d3.zip"],
)

http_archive(
    name = "io_bazel_rules_jsonnet",
    sha256 = "7f51f859035cd98bcf4f70dedaeaca47fe9fbae6b199882c516d67df416505da",
    strip_prefix = "rules_jsonnet-0.3.0",
    urls = ["https://github.com/bazelbuild/rules_jsonnet/archive/0.3.0.tar.gz"],
)

load("@io_bazel_rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_repositories")

jsonnet_repositories()

load("@jsonnet_go//bazel:repositories.bzl", "jsonnet_go_repositories")

jsonnet_go_repositories()

load("@jsonnet_go//bazel:deps.bzl", "jsonnet_go_dependencies")

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

go_repository(
    name = "com_github_gordonklaus_ineffassign",
    commit = "7953dde2c7bf4ce700d9f14c2e41c0966763760c",
    importpath = "github.com/gordonklaus/ineffassign",
)

go_repository(
    name = "com_github_buildbarn_bb_storage",
    commit = "ad94fa646ea6f2bf59a355585e6d94d81e353c53",
    importpath = "github.com/buildbarn/bb-storage",
)

go_repository(
    name = "com_github_buildbarn_bb_remote_execution",
    commit = "c3b5a3348f03c6f34191a068f3fc2486d3c19112",
    importpath = "github.com/buildbarn/bb-remote-execution",
)

go_repository(
    name = "com_github_buildbarn_bb_browser",
    commit = "e4b8dc6ea145ecd41f33d893226b7e628ea2acff",
    importpath = "github.com/buildbarn/bb-browser",
)

# TODO: This refers to a copy of go_dependencies.bzl that is manually
# copied from the bb-storage repository. This is a requirement to make
# "gazelle:repository_macro" work.
# Details: https://github.com/bazelbuild/bazel-gazelle/issues/752
# gazelle:repository_macro go_dependencies_bb_storage.bzl%bb_storage_go_dependencies
load(":go_dependencies_bb_storage.bzl", "bb_storage_go_dependencies")

bb_storage_go_dependencies()

load("@com_github_buildbarn_bb_browser//:go_dependencies.bzl", "bb_browser_go_dependencies")

bb_browser_go_dependencies()

http_archive(
    name = "com_github_twbs_bootstrap",
    build_file_content = """exports_files(["css/bootstrap.min.css", "js/bootstrap.min.js"])""",
    sha256 = "888ffd30b7e192381e2f6a948ca04669fdcc2ccc2ba016de00d38c8e30793323",
    strip_prefix = "bootstrap-4.3.1-dist",
    urls = ["https://github.com/twbs/bootstrap/releases/download/v4.3.1/bootstrap-4.3.1-dist.zip"],
)

http_file(
    name = "com_jquery_jquery",
    downloaded_file_path = "jquery.js",
    sha256 = "0497a8d2a9bde7db8c0466fae73e347a3258192811ed1108e3e096d5f34ac0e8",
    urls = ["https://code.jquery.com/jquery-3.4.0.min.js"],
)

load("@com_github_bazelbuild_remote_apis//:repository_rules.bzl", "switched_rules_by_language")

switched_rules_by_language(
    name = "bazel_remote_apis_imports",
    go = True,
)
