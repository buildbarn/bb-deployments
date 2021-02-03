local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  global: common.global,
  grpcServers: [{
    listenAddresses: [':8980'],
    authenticationPolicy: { allow: {} },
  }],
  schedulers: {
    '': { endpoint: { address: 'scheduler:8982' } },
  },
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
}
