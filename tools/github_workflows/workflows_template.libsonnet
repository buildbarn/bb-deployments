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
          name: 'Restore Bazelisk cache',
          uses: 'actions/cache@v1',
          with: { key: 'bazelisk', path: '~/.cache/bazelisk' },
        },
        {
          name: 'Installing Bazelisk',
          run: |||
            bazelisk_fingerprint=231ec5ca8115e94c75a1f4fbada1a062b48822ca04f21f26e4cb1cd8973cd458 &&
            (echo "${bazelisk_fingerprint} ${HOME}/.cache/bazelisk/bazel" | sha256sum --check --quiet) || (
              mkdir -p ~/.cache/bazelisk &&
              curl -L https://github.com/bazelbuild/bazelisk/releases/download/v1.11.0/bazelisk-linux-amd64 > ~/.cache/bazelisk/bazelisk.tmp &&
              chmod +x ~/.cache/bazelisk/bazelisk.tmp &&
              mv ~/.cache/bazelisk/bazelisk.tmp ~/.cache/bazelisk/bazel
            ) &&
            (echo "${bazelisk_fingerprint} ${HOME}/.cache/bazelisk/bazel" | sha256sum --check --quiet) &&
            echo "~/.cache/bazelisk" >> ${GITHUB_PATH}
          |||,
        },
        {
          name: 'Check out source code',
          uses: 'actions/checkout@v1',
        },
        {
          name: 'Gazelle',
          run: 'bazel run //:gazelle -- update-repos -from_file=go.mod -to_macro go_dependencies.bzl%go_dependencies -prune && bazel run //:gazelle',
        },
        {
          name: 'Buildifier',
          run: "sed '/^$/d' go_dependencies.bzl > go_dependencies.bzl.new && mv go_dependencies.bzl.new go_dependencies.bzl && bazel run @com_github_bazelbuild_buildtools//:buildifier",
        },
        {
          name: 'Gofmt',
          run: 'bazel run @cc_mvdan_gofumpt//:gofumpt -- -lang 1.18 -w -extra $(pwd)',
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
          name: 'Test style conformance',
          run: 'git diff --exit-code HEAD --',
        },
        {
          name: 'Golint',
          run: 'bazel run @org_golang_x_lint//golint -- -set_exit_status $(pwd)/...',
        },
        {
          name: 'Check for ineffective assignments',
          run: 'bazel run @com_github_gordonklaus_ineffassign//:ineffassign $(pwd)',
        },
        {
          name: 'Test bare deployment',
          run: 'tools/test-deployment-bare.sh',
        },
        {
          name: 'Test docker-compose deployment',
          run: 'tools/test-deployment-docker-compose.sh',
        },
      ] + std.flattenArrays([
        [{
          name: platform.name + ': build and test',
          run: ('bazel %s --platforms=@io_bazel_rules_go//go/toolchain:%s //...' % [
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
