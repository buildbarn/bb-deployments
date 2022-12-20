{
  globalWithDiagnosticsHttpServer(listenAddress): {
    diagnosticsHttpServer: {
      listenAddress: listenAddress,
      enablePrometheus: true,
      enablePprof: true,
      enableActiveSpans: true,
    },
  },

  blobstore: {
    contentAddressableStorage: {
      grpc: {
        address: 'localhost:8981',
      },
    },
    actionCache: {
      completenessChecking: {
        backend: {
          grpc: {
            address: 'localhost:8981',
          },
        },
        maximumTotalTreeSizeBytes: 64 * 1024 * 1024,
      },
    },
  },
  browserUrl: 'http://localhost:7984',
  maximumMessageSizeBytes: 16 * 1024 * 1024,
}
