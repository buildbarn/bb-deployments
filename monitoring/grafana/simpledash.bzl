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

    ctx.actions.run_shell(
        inputs = [
            ctx.executable._jb,
            jsonnetfile,
            jsonnetfile_lock,
        ],
        outputs = [out_dir],
        arguments = [args],
        command = """
        jb=$1
        jsonnetfile=$2
        jsonnetfile_lock=$3
        out_dir=$4

        cp $jsonnetfile .
        cp $jsonnetfile_lock .

        $jb install
        cp -r --dereference vendor/* $out_dir
    """,
    )

    return DefaultInfo(files = depset([out_dir]))

jb_library = rule(
    implementation = _jb_library_impl,
    attrs = {
        "_jb": attr.label(default = "@com_github_jsonnet_bundler_jsonnet_bundler//cmd/jb", executable = True, allow_single_file = True, cfg = "exec"),
        "jsonnetfile": attr.label(mandatory = True, allow_single_file = True),
        "jsonnetfile_lock": attr.label(mandatory = True, allow_single_file = True),
    },
)

def _simpledash_jsonnet_to_json_rule_impl(ctx, **kwargs):
    out_dir = ctx.actions.declare_directory(ctx.label.name)
    jsonnet_imports = " ".join(["-J {}".format(dirs.path) for dirs in ctx.files.imports])

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
        jsonnet_imports,
        out_dir.path,
        dashboards_file.path,
    ])

    ctx.actions.run_shell(
        inputs = [
            ctx.executable._jsonnet,
            config_file,
            dashboards_file,
        ] + dashboard_srcs + ctx.files._lib_srcs + ctx.files.imports,
        outputs = [out_dir],
        arguments = [args],
        command = """
            jsonnet=$1
            jsonnet_imports=$2
            out_dir=$3
            dashboards_file=$4

            cp --dereference $dashboards_file dashboards.libsonnet
            $jsonnet $jsonnet_imports -m $out_dir dashboards.libsonnet
        """,
    )

    return DefaultInfo(files = depset([out_dir]))

simpledash_jsonnet_to_json = rule(
    implementation = _simpledash_jsonnet_to_json_rule_impl,
    attrs = {
        "_jsonnet": attr.label(default = "@jsonnet_go//cmd/jsonnet", executable = True, allow_single_file = True, cfg = "exec"),
        "_jb": attr.label(default = "@com_github_jsonnet_bundler_jsonnet_bundler//cmd/jb", executable = True, allow_single_file = True, cfg = "exec"),
        "_jsonnetfile": attr.label(default = "jsonnetfile.json", allow_single_file = True, cfg = "exec"),
        "_jsonnetfile_lock": attr.label(default = "jsonnetfile.lock.json", allow_single_file = True, cfg = "exec"),
        "_config_src": attr.label(default = "config.libsonnet", allow_single_file = True),
        "_lib_srcs": attr.label_list(default = ["lib/grpc.libsonnet", "lib/simpledash.libsonnet"], allow_files = True),
        "srcs": attr.label_list(mandatory = True, allow_files = True),
        "imports": attr.label_list(allow_files = True),
    },
)
