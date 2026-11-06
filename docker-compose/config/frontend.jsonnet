local common = import 'common.libsonnet';
local topology = import 'topology.libsonnet';

local existenceCache = {
  cacheSize: 1000000,
  cacheDuration: '60s',
  cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
};

{
  grpcServers: [{
    listenAddresses: [':8980'],
    authenticationPolicy: { allow: {} },
  }],
  schedulers: {
    '': {
      endpoint: {
        address: 'scheduler:8982',
        addMetadataJmespathExpression: {
          expression: |||
            {
              "build.bazel.remote.execution.v2.requestmetadata-bin": incomingGRPCMetadata."build.bazel.remote.execution.v2.requestmetadata-bin"
            }
          |||,
        },
      },
    },
  },
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  global: common.global,
  supportedCompressors: ['ZSTD'],
  contentAddressableStorageServer: {
    contentAddressableStorage: {
      chunkStorage: {
        existenceCaching: {
          backend: topology.chunkStorage,
          existenceCache: existenceCache,
        },
      },
      chunkMappingStorage: {
        existenceCaching: {
          backend: topology.chunkMappingStorage,
          existenceCache: existenceCache,
        },
      },
      cdcParameterCache: topology.cdcParameterCache,
    },
    getAuthorizer: { allow: {} },
    putAuthorizer: { allow: {} },
    findMissingAuthorizer: { allow: {} },
    maximumChunkCount: 100000,
  },
  actionCache: {
    backend: topology.actionCache,
    getAuthorizer: { allow: {} },
    putAuthorizer: { allow: {} },
  },
  fileSystemAccessCache: {
    backend: topology.fileSystemAccessCache,
    getAuthorizer: { allow: {} },
    putAuthorizer: { allow: {} },
  },
  executeAuthorizer: { allow: {} },
}
