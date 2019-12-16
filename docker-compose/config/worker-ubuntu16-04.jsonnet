local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  browserUrl: common.browserUrl,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  scheduler: { address: 'scheduler:8983' },
  httpListenAddress: ':7986',
  maximumMemoryCachedDirectories: 1000,
  localBuildDirectory: {
    buildDirectoryPath: '/worker/build',
    cacheDirectoryPath: '/worker/cache',
    maximumCacheFileCount: 10000,
    maximumCacheSizeBytes: 1024 * 1024 * 1024,
    cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
  },
  instanceName: 'remote-execution',
  runners: [{
    endpoint: { address: 'unix:///worker/runner' },
    concurrency: 8,
    platform: {
      properties: [
        { name: 'OSFamily', value: 'Linux' },
        { name: 'container-image', value: 'docker://marketplace.gcr.io/google/rbe-ubuntu16-04@sha256:6ad1d0883742bfd30eba81e292c135b95067a6706f3587498374a083b7073cb9' },
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
}
