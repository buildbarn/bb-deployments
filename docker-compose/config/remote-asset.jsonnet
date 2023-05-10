local common = import 'common.libsonnet';
{
  fetcher: {
    caching: {
      fetcher: {
        http: {
          allowUpdatesForInstances: ['fuse', 'hardlinking'],
          contentAddressableStorage: common.blobstore.contentAddressableStorage,
        },
      },
    },
  },

  assetCache: {
    actionCache: {
      blobstore: common.blobstore,
    },
  },
  global: common.global,
  grpcServers: [{
    listenAddresses: [':8984'],
    authenticationPolicy: { allow: {} },
  }],
  allowUpdatesForInstances: ['foo'],
  maximumMessageSizeBytes: 16 * 1024 * 1024 * 1024,
}
