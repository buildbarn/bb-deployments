{
  local platforms = [
    {
      name: 'linux_amd64',
      buildAndTestCommand: 'build',
      buildJustBinaries: false,
      extension: '',
    },
    {
      name: 'linux_386',
      buildAndTestCommand: 'build',
      buildJustBinaries: false,
      extension: '',
    },
    {
      name: 'linux_arm',
      buildAndTestCommand: 'build',
      buildJustBinaries: false,
      extension: '',
    },
    {
      name: 'linux_arm64',
      buildAndTestCommand: 'build',
      buildJustBinaries: false,
      extension: '',
    },
    {
      name: 'darwin_amd64',
      buildAndTestCommand: 'build',
      buildJustBinaries: false,
      extension: '',
    },
    {
      name: 'darwin_arm64',
      buildAndTestCommand: 'build',
      buildJustBinaries: false,
      extension: '',
    },
    {
      name: 'freebsd_amd64',
      buildAndTestCommand: 'build',
      // Building '//...' is broken for FreeBSD, because rules_docker
      // doesn't want to initialize properly.
      buildJustBinaries: true,
      extension: '',
    },
    {
      name: 'windows_amd64',
      buildAndTestCommand: 'build',
      buildJustBinaries: false,
      extension: '.exe',
    },
  ],

  local getJobs(binaries, containers, doUpload) = {
    build_and_test: {
      'runs-on': 'ubuntu-latest',
      steps: [
        {
          name: 'Installing grpcurl',
          run: |||
            mkdir -p ~/.cache/grpcurl &&
            curl -L https://github.com/fullstorydev/grpcurl/releases/download/v1.8.9/grpcurl_1.8.9_linux_x86_64.tar.gz | tar -xz -C ~/.cache/grpcurl &&
            echo "~/.cache/grpcurl" >> ${GITHUB_PATH}
          |||,
        },
        {
          name: 'Install k3d',
          run: 'curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash',
        },
        {
          name: 'Check out source code',
          uses: 'actions/checkout@v1',
        },
        {
          name: 'Installing Bazel',
          run: 'v=$(cat .bazelversion) && curl -L https://github.com/bazelbuild/bazel/releases/download/${v}/bazel-${v}-linux-x86_64 > ~/bazel && chmod +x ~/bazel && echo ~ >> ${GITHUB_PATH}',
        },
        {
          name: 'Gazelle',
          run: 'bazel run //:gazelle',
        },
        {
          name: 'Buildifier',
          run: 'bazel run //:buildifier.check',
        },
        {
          name: 'Gofmt',
          run: 'bazel run @cc_mvdan_gofumpt//:gofumpt -- -w -extra $(pwd)',
        },
        {
          name: 'GitHub workflows',
          run: 'bazel build //tools/github_workflows && cp bazel-bin/tools/github_workflows/*.yaml .github/workflows',
        },
        {
          name: 'Check the diff between docker-compose and Kubernetes configs',
          run: 'tools/diff-docker-and-k8s-configs.sh > tools/expected-docker-and-k8s-configs.diff',
        },
        {
          name: 'Update versions of the container images',
          run: 'tools/update-container-image-versions.sh',
        },
        {
          name: 'Test style conformance',
          run: 'git diff --exit-code HEAD --',
        },
        {
          name: 'Golint',
          run: 'bazel run @org_golang_x_lint//golint -- -set_exit_status $(pwd)/...',
        },
        {
          name: 'Test bare deployment',
          run: 'tools/test-deployment-bare.sh',
        },
        {
          name: 'Test docker-compose deployment',
          run: 'tools/test-deployment-docker-compose.sh',
        },
        {
          name: 'Test Kubernetes deployment',
          run: 'tools/test-deployment-kubernetes',
        },
        {
          name: 'bazel mod integrity',
          run: 'bazel mod graph',
        },
      ] + std.flattenArrays([
        [{
          name: platform.name + ': build and test',
          run: ('bazel %s --platforms=@rules_go//go/toolchain:%s //...' % [
                  platform.buildAndTestCommand,
                  platform.name,
                ]),
        }]
        for platform in platforms
      ]),
    },
  },

  getWorkflows(binaries, containers): {
    'master.yaml': {
      name: 'master',
      on: { push: { branches: ['master'] } },
      jobs: getJobs(binaries, containers, true),
    },
    'pull-requests.yaml': {
      name: 'pull-requests',
      on: { pull_request: { branches: ['master'] } },
      jobs: getJobs(binaries, containers, false),
    },
  },
}
