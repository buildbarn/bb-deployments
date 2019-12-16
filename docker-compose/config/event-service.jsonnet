local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  httpListenAddress: ':7985',
  grpcServers: [{
    listenAddresses: [':8985'],
    authenticationPolicy: { allow: {} },
  }],
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
}
