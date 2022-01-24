local common = import 'common.libsonnet';

{
  blobstore: {
    contentAddressableStorage: {
      'local': {
        keyLocationMapOnBlockDevice: {
          file: {
            path: '/storage-cas/key_location_map',
            sizeBytes: 100 * 1024 * 1024,
          },
        },
        keyLocationMapMaximumGetAttempts: 8,
        keyLocationMapMaximumPutAttempts: 32,
        oldBlocks: 8,
        currentBlocks: 24,
        newBlocks: 1,
        blocksOnBlockDevice: {
          source: {
            file: {
              path: '/storage-cas/blocks',
              sizeBytes: 2 * 1024 * 1024 * 1024,
            },
          },
          spareBlocks: 3,
        },
        persistent: {
          stateDirectoryPath: '/storage-cas/persistent_state',
          minimumEpochInterval: '300s',
        },
      },
    },
    actionCache: {
      'local': {
        keyLocationMapOnBlockDevice: {
          file: {
            path: '/storage-ac/key_location_map',
            sizeBytes: 1024 * 1024,
          },
        },
        keyLocationMapMaximumGetAttempts: 8,
        keyLocationMapMaximumPutAttempts: 32,
        oldBlocks: 8,
        currentBlocks: 24,
        newBlocks: 1,
        blocksOnBlockDevice: {
          source: {
            file: {
              path: '/storage-ac/blocks',
              sizeBytes: 20 * 1024 * 1024,
            },
          },
          spareBlocks: 3,
        },
        persistent: {
          stateDirectoryPath: '/storage-ac/persistent_state',
          minimumEpochInterval: '300s',
        },
      },
    },
  },
  global: common.global,
  grpcServers: [{
    listenAddresses: [':8981'],
    authenticationPolicy: { allow: {} },
  }],
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  executeAuthorizer: { allow: {} },
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
