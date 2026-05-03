local common = import 'common.libsonnet';

{
  buildDirectoryPath: '/worker/build',
  // TODO: global: common.global,
  grpcServers: [{
    listenAddresses: [':50051'],
    authenticationPolicy: { allow: {} },
  }],
}
