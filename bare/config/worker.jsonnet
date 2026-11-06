local common = import 'common.libsonnet';
local topology = import 'topology.libsonnet';
local os = std.extVar('OS');

local chunkMappingCache = {
  cacheSize: 10000,
  cacheDuration: '60s',
  cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
};
local chunkCache = {
  cacheSize: 10000,
  cacheDuration: '60s',
  cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
};

{
  blobstore: {
    actionCache: topology.actionCache,
    contentAddressableStorage: {
      chunkStorage: {
        readCaching: {
          slow: topology.chunkStorage,
          fast: {
            'local': {
              keyLocationMap: {
                onBlockDevice: {
                  file: {
                    path: 'worker/cs/key_location_map',
                    sizeBytes: 400 * 1024 * 1024,
                  },
                },
                maximumGetAttempts: 16,
                maximumPutAttempts: 64,
              },
              oldBlocks: 8,
              currentBlocks: 24,
              newBlocks: 3,
              blocksOnBlockDevice: {
                source: {
                  file: {
                    path: 'worker/cs/blocks',
                    sizeBytes: 32 * 1024 * 1024 * 1024,
                  },
                },
                spareBlocks: 3,
              },
              persistent: {
                stateDirectoryPath: 'worker/cs/persistent_state',
                minimumEpochInterval: '300s',
              },
            },
          },
          replicator: { deduplicating: { 'local': {} } },
        },
      },
      chunkMappingStorage: topology.chunkMappingStorage,
      cdcParameterCache: topology.cdcParameterCache,
    } + (if os == 'Windows' then {
      // Only the virtual (FUSE/WinFSP) build directory performs
      // repeated random access reads of the same blobs. The native
      // build directory fetches each blob once into its hardlinking
      // cache, so caching parsed chunk mappings and decompressed chunks
      // would only waste memory.
      chunkMappingCache: chunkMappingCache,
      chunkCache: chunkCache,
    } else {}),
  },
  portalUrl: common.portalUrl,
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
