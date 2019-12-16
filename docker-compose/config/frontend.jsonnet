local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  httpListenAddress: ':7980',
  grpcServers: [{
    listenAddresses: [':8980'],
    authenticationPolicy: { allow: {} },
  }],
  schedulers: {
    'remote-execution': { address: 'scheduler:8982' },
  },
  verifyActionResultCompleteness: true,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
}
