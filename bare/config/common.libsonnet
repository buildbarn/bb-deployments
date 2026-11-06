{
  globalWithDiagnosticsHttpServer(listenAddress): {
    diagnosticsHttpServer: {
      httpServers: [{
        listenAddresses: [listenAddress],
        authenticationPolicy: { allow: {} },
      }],
      enablePrometheus: true,
      enablePprof: true,
      enableActiveSpans: true,
    },
  },
  portalUrl: 'http://localhost:8081/browser',
  maximumMessageSizeBytes: 2 * 1024 * 1024,
}
