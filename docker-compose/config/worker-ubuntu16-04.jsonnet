local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  scheduler: { address: 'scheduler:8983' },
  httpListenAddress: ':7986',
  maximumMemoryCachedDirectories: 1000,
  instanceName: 'remote-execution',
  buildDirectories: [{
    native: {
      buildDirectoryPath: '/worker/build',
      cacheDirectoryPath: '/worker/cache',
      maximumCacheFileCount: 10000,
      maximumCacheSizeBytes: 1024 * 1024 * 1024,
      cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
    },
    runners: [{
      endpoint: { address: 'unix:///worker/runner' },
      concurrency: 8,
      platform: {
        properties: [
          { name: 'OSFamily', value: 'Linux' },
          { name: 'container-image', value: 'docker://marketplace.gcr.io/google/rbe-ubuntu16-04@sha256:b516a2d69537cb40a7c6a7d92d0008abb29fba8725243772bdaf2c83f1be2272' },
        ],
      },
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
