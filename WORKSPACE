workspace(name = "com_github_buildbarn_bb_deployments")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

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
    sha256 = "144290c4166bd67e76a54f96cd504ed86416ca3ca82030282760f0823c10be48",
    strip_prefix = "bazel-toolchains-3.1.1",
    urls = [
        "https://github.com/bazelbuild/bazel-toolchains/releases/download/3.1.1/bazel-toolchains-3.1.1.tar.gz",
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-toolchains/archive/3.1.1.tar.gz",
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
