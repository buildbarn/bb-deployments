{
  blobstore: {
    contentAddressableStorage: {
      sharding: {
        hashInitialization: 11946695773637837490,
        shards: [
          {
            backend: { grpc: { address: 'storage-0:8981' } },
            weight: 1,
          },
          {
            backend: { grpc: { address: 'storage-1:8981' } },
            weight: 1,
          },
        ],
      },
    },
    actionCache: {
      completenessChecking: {
        backend: {
          sharding: {
            hashInitialization: 14897363947481274433,
            shards: [
              {
                backend: { grpc: { address: 'storage-0:8981' } },
                weight: 1,
              },
              {
                backend: { grpc: { address: 'storage-1:8981' } },
                weight: 1,
              },
            ],
          },
        },
        maximumTotalTreeSizeBytes: 64 * 1024 * 1024,
      },
    },
  },
  browserUrl: 'http://localhost:7984',
  httpServers: [{
    listenAddresses: [':80'],
    authenticationPolicy: { allow: {} },
  }],
  maximumMessageSizeBytes: 16 * 1024 * 1024,
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
