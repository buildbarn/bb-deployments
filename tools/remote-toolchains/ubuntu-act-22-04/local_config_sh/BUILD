load("@rules_shell//shell/toolchains:sh_toolchain.bzl", "sh_toolchain")

sh_toolchain(
    name = "local_sh",
    path = "/usr/bin/bash",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "local_sh_toolchain",
    toolchain = ":local_sh",
    toolchain_type = "@bazel_tools//tools/sh:toolchain_type",
)
