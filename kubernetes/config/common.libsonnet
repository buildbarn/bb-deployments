{
  blobstore: {
    contentAddressableStorage: {
      sharding: {
        shards: {
          "0": {
            backend: { grpc: { address: 'storage-0.storage.buildbarn:8981' } },
            weight: 1,
          },
          "1": {
            backend: { grpc: { address: 'storage-1.storage.buildbarn:8981' } },
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
                backend: { grpc: { address: 'storage-0.storage.buildbarn:8981' } },
                weight: 1,
              },
              "1": {
                backend: { grpc: { address: 'storage-1.storage.buildbarn:8981' } },
                weight: 1,
              },
            },
          },
        },
        maximumTotalTreeSizeBytes: 64 * 1024 * 1024,
      },
    },
  },
  browserUrl: 'http://bb-browser.example.com:80',
  maximumMessageSizeBytes: 2 * 1024 * 1024,
  global: {
    diagnosticsHttpServer: {
      httpServers: [{
        listenAddresses: [':9980'],
        authenticationPolicy: { allow: {} },
      }],
      enablePrometheus: true,
      enablePprof: true,
      enableActiveSpans: true,
    },
  },
}
