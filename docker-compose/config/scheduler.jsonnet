local common = import 'common.libsonnet';

{
  httpListenAddress: ':7982',
  clientGrpcServers: [{
    listenAddresses: [':8982'],
    authenticationPolicy: { allow: {} },
  }],
  workerGrpcServers: [{
    listenAddresses: [':8983'],
    authenticationPolicy: { allow: {} },
  }],
  browserUrl: common.browserUrl,
  blobstore: common.blobstore,
}
