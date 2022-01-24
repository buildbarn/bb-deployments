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
  executeAuthorizer: { allow: {} },
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  contentAddressableStorageAuthorizers: {
    get: { allow: {} },
    put: { allow: {} },
    findMissing: { allow: {} },
  },
  actionCacheAuthorizers: {
    get: { allow: {} },
    put: { allow: {} },
  },
}
