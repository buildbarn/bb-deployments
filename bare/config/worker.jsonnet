local common = import 'common.libsonnet';
local os = std.extVar('OS');

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
                path: 'worker/cas/key_location_map',
                sizeBytes: 400 * 1024 * 1024,
              },
            },
            keyLocationMapMaximumGetAttempts: 16,
            keyLocationMapMaximumPutAttempts: 64,
            oldBlocks: 8,
            currentBlocks: 24,
            newBlocks: 3,
            blocksOnBlockDevice: {
              source: {
                file: {
                  path: 'worker/cas/blocks',
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
              stateDirectoryPath: 'worker/cas/persistent_state',
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
  scheduler: { address: 'localhost:8983' },
  global: common.globalWithDiagnosticsHttpServer(':9986'),
  buildDirectories: [
    (if os == 'Windows' then {
       virtual: {
         maximumExecutionTimeoutCompensation: '3600s',
         shuffleDirectoryListings: true,
         maximumWritableFileUploadDelay: '60s',
         caseInsensitive: true,
         mount: {
           // https://github.com/winfsp/winfsp/issues/573
           mountPath: '\\\\.\\b:',
           winfsp: {},
         },
       },
     } else {
       native: {
         buildDirectoryPath: std.extVar('PWD') + '/worker/build',
         cacheDirectoryPath: 'worker/cache',
         maximumCacheFileCount: 10000,
         maximumCacheSizeBytes: 1024 * 1024 * 1024,
         cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
       },
     }) + {
      runners: [{
        // https://github.com/grpc/grpc/blob/master/doc/naming.md
        endpoint: { address: 'unix:worker/runner' },
        concurrency: 8,
        maximumFilePoolFileCount: 10000,
        maximumFilePoolSizeBytes: 1024 * 1024 * 1024,
        platform: {},
        workerId: {
          datacenter: 'paris',
          rack: '4',
          slot: '15',
          hostname: 'ubuntu-worker.example.com',
        },
      }],
    },
  ],
  filePool: {
    blockDevice: {
      file: {
        path: 'worker/filepool',
        sizeBytes: 1024 * 1024 * 1024,
      },
    },
  },
  inputDownloadConcurrency: 10,
  outputUploadConcurrency: 11,
  directoryCache: {
    maximumCount: 1000,
    maximumSizeBytes: 1000 * 1024,
    cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
  },
}
