local common = import 'common.libsonnet';

{
  buildDirectoryPath: '/worker/build',
  // TODO: global: common.global,
  grpcServers: [{
    listenPaths: ['/worker/runner'],
    authenticationPolicy: { allow: {} },
  }],
}
