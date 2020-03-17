local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  browserUrl: common.browserUrl,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  scheduler: { address: 'localhost:8983' },
  httpListenAddress: ':7986',
  maximumMemoryCachedDirectories: 1000,
  instanceName: 'local',
  build_directories: [{
    native: {
      buildDirectoryPath: 'build',
      cacheDirectoryPath: 'cache',
      maximumCacheFileCount: 10000,
      maximumCacheSizeBytes: 1024 * 1024 * 1024,
      cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
    },
    runners: [{
      endpoint: { address: 'unix://runner' },
      concurrency: 8,
      platform: {},
      defaultExecutionTimeout: '1800s',
      maximumExecutionTimeout: '3600s',
      workerId: {
        datacenter: 'paris',
        rack: '4',
        slot: '15',
        hostname: 'ubuntu-worker.example.com',
      },

    }],
  }],
}
