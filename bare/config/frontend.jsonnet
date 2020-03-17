local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  httpListenAddress: ':7980',
  grpcServers: [{
    listenAddresses: [':8980'],
    authenticationPolicy: { allow: {} },
  }],
  schedulers: {
    'local': { address: 'localhost:8982' },
  },
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
}
