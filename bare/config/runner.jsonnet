local common = import 'common.libsonnet';
local os = std.extVar('OS');

{
  buildDirectoryPath: if os == 'Windows' then 'b:\\' else (std.extVar('PWD') + '/worker/build'),
  global: common.globalWithDiagnosticsHttpServer(':9987'),
  grpcServers: [{
    listenPaths: ['worker/runner'],
    authenticationPolicy: { allow: {} },
  }],
}
