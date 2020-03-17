{
  blobstore: {
    contentAddressableStorage: {
      grpc: {
        address: 'localhost:8981',
      },
    },
    actionCache: {
      grpc: {
        address: 'localhost:8981',
      },
    },
  },
  browserUrl: 'http://localhost:7984',
  maximumMessageSizeBytes: 16 * 1024 * 1024,
}
