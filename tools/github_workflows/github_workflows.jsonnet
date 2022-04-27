local workflows_template = import 'tools/github_workflows/workflows_template.libsonnet';

workflows_template.getWorkflows(
  [],  // No binaries to build under under //cmd
  [],  // No containers to build
)
