local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  browserUrl: common.browserUrl,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  scheduler: { address: 'localhost:8983' },
  maximumMemoryCachedDirectories: 1000,
  global: common.globalWithDiagnosticsHttpServer(':9986'),
  buildDirectories: [{
    native: {
      buildDirectoryPath: std.extVar('PWD') + '/build',
      cacheDirectoryPath: 'cache',
      maximumCacheFileCount: 10000,
      maximumCacheSizeBytes: 1024 * 1024 * 1024,
      cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
    },
    runners: [{
      # https://github.com/grpc/grpc/blob/master/doc/naming.md
      endpoint: { address: 'unix:runner' },
      concurrency: 8,
      platform: {},
      workerId: {
        datacenter: 'paris',
        rack: '4',
        slot: '15',
        hostname: 'ubuntu-worker.example.com',
      },
    }],
  }],
  outputUploadConcurrency: 11,
}
