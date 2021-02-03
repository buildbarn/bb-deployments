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
    },
  },
  browserUrl: 'http://localhost:7984',
  httpListenAddress: ':80',
  maximumMessageSizeBytes: 16 * 1024 * 1024,
  global: { diagnosticsHttpListenAddress: ':9980' },
}
