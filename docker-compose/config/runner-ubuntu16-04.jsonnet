local common = import 'common.libsonnet';

{
  buildDirectoryPath: '/worker/build',
  global: common.global,
  grpcServers: [{
    listenPaths: ['/worker/runner'],
    authenticationPolicy: { allow: {} },
  }],
}
