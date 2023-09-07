local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  httpServers: [{
    listenAddresses: [':7984'],
    authenticationPolicy: { allow: {} },
  }],
  global: common.globalWithDiagnosticsHttpServer(':9984'),
  authorizer: { allow: {} },
}
