local common = import 'common.libsonnet';

// The FUSE worker is the most efficient configuration.
// This is preferred to the hardlinking configuration.
{
  blobstore: {
    actionCache: common.blobstore.actionCache,
    contentAddressableStorage: {
      readCaching: {
        slow: common.blobstore.contentAddressableStorage,
        fast: {
          'local': {
            keyLocationMapOnBlockDevice: {
              file: {
                path: '/worker/cas/key_location_map',
                sizeBytes: 400 * 1024 * 1024,
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
                  path: '/worker/cas/blocks',
                  sizeBytes: 32 * 1024 * 1024 * 1024,
                },
              },
              spareBlocks: 3,
              dataIntegrityValidationCache: {
                cacheSize: 50000,
                cacheDuration: '14400s',
                cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
              },
            },
            persistent: {
              stateDirectoryPath: '/worker/cas/persistent_state',
              minimumEpochInterval: '300s',
            },
          },
        },
        replicator: { deduplicating: { 'local': {} } },
      },
    },
  },
  browserUrl: common.browserUrl,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  scheduler: { address: 'scheduler:8983' },
  global: common.global,
  buildDirectories: [{
    virtual: {
      maximumExecutionTimeoutCompensation: '3600s',
      shuffleDirectoryListings: true,
      maximumWritableFileUploadDelay: '60s',
      mount: {
        mountPath: '/worker/build',
        fuse: {
          directoryEntryValidity: '300s',
          inodeAttributeValidity: '300s',
          allowOther: true,
          directMount: true,
        },
      },
    },
    runners: [{
      endpoint: { address: 'unix:///worker/runner' },
      concurrency: 8,
      instanceNamePrefix: 'fuse',
      platform: {
        properties: [
          { name: 'OSFamily', value: 'linux' },
          { name: 'container-image', value: 'docker://ghcr.io/catthehacker/ubuntu:act-22.04@sha256:5f9c35c25db1d51a8ddaae5c0ba8d3c163c5e9a4a6cc97acd409ac7eae239448' },
        ],
      },
      maximumFilePoolFileCount: 100000,
      maximumFilePoolSizeBytes: 1 * 1024 * 1024 * 1024,
      workerId: {
        datacenter: 'amsterdam',
        rack: '3',
        slot: '10',
        hostname: 'ubuntu-worker.example.com',
      },
    }],
  }],
  filePool: {
    blockDevice: {
      file: {
        path: '/worker/filepool',
        // concurrency * maximumFilePoolSizeBytes
        sizeBytes: 8 * 1024 * 1024 * 1024,
      },
    },
  },
  outputUploadConcurrency: 11,
  directoryCache: {
    maximumCount: 1000,
    maximumSizeBytes: 1000 * 1024,
    cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
  },
}
