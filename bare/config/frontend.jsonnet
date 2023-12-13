local common = import 'common.libsonnet';

{
  grpcServers: [{
    listenAddresses: [':8980'],
    authenticationPolicy: { allow: {} },
  }],
  schedulers: {
    '': {
      endpoint: {
        address: 'localhost:8982',
        addMetadataJmespathExpression: |||
          {
            "build.bazel.remote.execution.v2.requestmetadata-bin": incomingGRPCMetadata."build.bazel.remote.execution.v2.requestmetadata-bin"
          }
        |||,
      },
    },
  },
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  global: common.globalWithDiagnosticsHttpServer(':9980'),
  contentAddressableStorage: {
    backend: common.blobstore.contentAddressableStorage,
    getAuthorizer: { allow: {} },
    putAuthorizer: { allow: {} },
    findMissingAuthorizer: { allow: {} },
  },
  actionCache: {
    backend: common.blobstore.actionCache,
    getAuthorizer: { allow: {} },
    putAuthorizer: { allow: {} },
  },
  executeAuthorizer: { allow: {} },
}
