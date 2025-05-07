{
  blobstore: {
    contentAddressableStorage: {
      sharding: {
        shards: {
          "0": {
            backend: { grpc: { address: 'storage-0:8981' } },
            weight: 1,
          },
          "1": {
            backend: { grpc: { address: 'storage-1:8981' } },
            weight: 1,
          },
        },
      },
    },
    actionCache: {
      completenessChecking: {
        backend: {
          sharding: {
            shards: {
              "0": {
                backend: { grpc: { address: 'storage-0:8981' } },
                weight: 1,
              },
              "1": {
                backend: { grpc: { address: 'storage-1:8981' } },
                weight: 1,
              },
            },
          },
        },
        maximumTotalTreeSizeBytes: 64 * 1024 * 1024,
      },
    },
  },
  browserUrl: 'http://localhost:7984',
  maximumMessageSizeBytes: 2 * 1024 * 1024,
  global: {
    diagnosticsHttpServer: {
      httpServers: [{
        listenAddresses: [':80'],
        authenticationPolicy: { allow: {} },
      }],
      enablePrometheus: true,
      enablePprof: true,
      enableActiveSpans: true,
    },
  },
}
