local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  listenAddress: ':7984',
  global: common.globalWithDiagnosticsHttpServer(':9984'),
  authorizer: { allow: {} },
}
