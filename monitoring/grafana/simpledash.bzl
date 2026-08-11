def _jb_library_impl(ctx, **kwargs):
    out_dir = ctx.actions.declare_directory(ctx.label.name)
    jsonnetfile = ctx.file.jsonnetfile
    jsonnetfile_lock = ctx.file.jsonnetfile_lock
    args = ctx.actions.args()
    args.add_all([
        ctx.executable._jb.path,
        jsonnetfile.path,
        jsonnetfile_lock.path,
        out_dir.path,
    ])

    ctx.actions.run(
        executable = ctx.executable._jb_script,
        inputs = [
            ctx.executable._jb,
            jsonnetfile,
            jsonnetfile_lock,
        ],
        outputs = [out_dir],
        arguments = [args],
        mnemonic = "JsonnetBundler",
        progress_message = "Jsonnet bundling into %{output}",
    )

    return DefaultInfo(files = depset([out_dir]))

jb_library = rule(
    doc = "Fetches and exports Jsonnet dependencies from Jsonnet Bundler project files.",
    implementation = _jb_library_impl,
    attrs = {
        "_jb": attr.label(default = "@com_github_jsonnet_bundler_jsonnet_bundler//cmd/jb", executable = True, allow_single_file = True, cfg = "exec"),
        "_jb_script": attr.label(default = ":run_jb", executable = True, cfg = "exec"),
        "jsonnetfile": attr.label(mandatory = True, allow_single_file = True),
        "jsonnetfile_lock": attr.label(mandatory = True, allow_single_file = True),
    },
)

def _simpledash_jsonnet_to_json_rule_impl(ctx, **kwargs):
    out_dir = ctx.actions.declare_directory(ctx.label.name)

    config_file = ctx.file._config_src
    dashboard_srcs = ctx.files.srcs
    dashboards_file = ctx.actions.declare_file(
        "dashboards.libsonnet",
    )

    # Construct file "dashboards.libsonnet" which acts as a build entrypoint,
    # and ensures that the dashboards can see config.libsonnet.
    dashboards_import_statements = " +\n".join(["  (import '%s')" % dashboard.path for dashboard in ctx.files.srcs])
    dashboards_file_content = """local dashboards = (
%s +
  (import '%s')
).dashboards;

{
  [dashboardName]: dashboards[dashboardName]
  for dashboardName in std.objectFields(dashboards)
}
""" % (dashboards_import_statements, config_file.path)

    ctx.actions.write(
        output = dashboards_file,
        content = dashboards_file_content,
    )

    args = ctx.actions.args()
    args.add_all([
        ctx.executable._jsonnet.path,
        out_dir.path,
        dashboards_file.path,
    ])
    args.add_all(
        ctx.files.imports,
        before_each = "-J",
        expand_directories = False,
    )

    ctx.actions.run(
        executable = ctx.executable._jsonnet_script,
        inputs = [
            ctx.executable._jsonnet,
            config_file,
            dashboards_file,
        ] + dashboard_srcs + ctx.files._lib_srcs + ctx.files.imports,
        outputs = [out_dir],
        arguments = [args],
        mnemonic = "Jsonnet",
        progress_message = "Jsonnet generating dashboards into %{output}",
    )

    return DefaultInfo(files = depset([out_dir]))

simpledash_jsonnet_to_json = rule(
    doc = "Generates JSON dashboards from Simpledash dashboard files.",
    implementation = _simpledash_jsonnet_to_json_rule_impl,
    attrs = {
        "_jsonnet": attr.label(default = "@jsonnet_go//cmd/jsonnet", executable = True, allow_single_file = True, cfg = "exec"),
        "_jb": attr.label(default = "@com_github_jsonnet_bundler_jsonnet_bundler//cmd/jb", executable = True, allow_single_file = True, cfg = "exec"),
        "_jsonnetfile": attr.label(default = "jsonnetfile.json", allow_single_file = True, cfg = "exec"),
        "_jsonnetfile_lock": attr.label(default = "jsonnetfile.lock.json", allow_single_file = True, cfg = "exec"),
        "_jsonnet_script": attr.label(default = ":run_jsonnet", executable = True, cfg = "exec"),
        "_config_src": attr.label(default = "config.libsonnet", allow_single_file = True),
        "_lib_srcs": attr.label_list(default = ["lib/grpc.libsonnet", "lib/simpledash.libsonnet"], allow_files = True),
        "srcs": attr.label_list(mandatory = True, allow_files = True),
        "imports": attr.label_list(allow_files = True),
    },
)
