local common = import 'common.libsonnet';

{
  buildDirectoryPath: std.extVar('PWD') + '/build',
  global: common.globalWithDiagnosticsHttpServer(':9987'),
  grpcServers: [{
    listenPaths: ['runner'],
    authenticationPolicy: { allow: {} },
  }],
}
