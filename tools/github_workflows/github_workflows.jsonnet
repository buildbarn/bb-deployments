local workflows_template = import 'tools/github_workflows/workflows_template.libsonnet';

workflows_template.getWorkflows(
  [],  // No binaries to build under under //cmd
  [],  // No containers to build
  [
    {
      name: 'Installing grpcurl',
      run: |||
        mkdir -p ~/.cache/grpcurl &&
        curl -L https://github.com/fullstorydev/grpcurl/releases/download/v1.8.9/grpcurl_1.8.9_linux_x86_64.tar.gz | tar -xz -C ~/.cache/grpcurl &&
        echo "~/.cache/grpcurl" >> ${GITHUB_PATH}
      |||,
      'if': "matrix.host.platform_name == 'linux_amd64'",
    },
    {
      name: 'Install k3d',
      run: 'curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash',
      'if': "matrix.host.platform_name == 'linux_amd64'",
    },
    {
      name: 'Install WinFSP',
      run: 'choco install winfsp',
      'if': "matrix.host.platform_name == 'windows_amd64'",
    },
  ],
  [
    {
      name: 'Check the diff between docker-compose and Kubernetes configs',
      run: 'tools/diff-docker-and-k8s-configs.sh > tools/expected-docker-and-k8s-configs.diff',
      'if': 'matrix.host.lint',
    },
    {
      name: 'Update versions of the container images',
      run: 'tools/update-container-image-versions.sh',
      'if': 'matrix.host.lint',
    },
    {
      name: 'Test bb-deployments style conformance',
      run: 'git diff --exit-code HEAD --',
      'if': 'matrix.host.lint',
    },
    {
      name: 'Test bare deployment',
      run: 'tools/test-deployment-bare.sh',
      shell: 'bash',
    },
    {
      name: 'Test docker-compose deployment',
      run: 'tools/test-deployment-docker-compose.sh',
      'if': "matrix.host.platform_name == 'linux_amd64'",
    },
    {
      name: 'Test Kubernetes deployment',
      run: 'tools/test-deployment-kubernetes',
      'if': "matrix.host.platform_name == 'linux_amd64'",
    },
    {
      name: 'bazel mod integrity',
      run: 'bazel mod graph',
      'if': 'matrix.host.lint',
    },
  ]
)
