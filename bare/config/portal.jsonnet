local common = import 'common.libsonnet';

{
  global: common.globalWithDiagnosticsHttpServer(':9983'),

  httpServers: [{
    listenAddresses: [':8081'],
    authenticationPolicy: { allow: {} },
  }],

  instanceNameAuthorizer: {
    allow: {},
  },
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,

  // besServiceConfiguration is disabled as it requires a Postgres instance.

  contentAddressableStorage: common.blobstore.contentAddressableStorage,
  actionCache: common.blobstore.contentAddressableStorage,
  initialSizeClassCache: common.blobstore.contentAddressableStorage,
  fileSystemAccessCache: common.blobstore.contentAddressableStorage,

  schedulerServiceConfiguration: {
    buildQueueStateClient: {
      address: 'localhost:8984',
    },
    killOperationsAuthorizer: {
      allow: {},
    },
    listOperationsPageSize: 500,
  },

  frontendServiceConfiguration: {
    frontendSource: {
      embedded: {},
    },
    frontendConfig: {
      companyName: 'Example Co',
      grpcBackendUrl: 'grpc://localhost:8082',
      featureFlags: {
        browser: {},
        scheduler: {},
      },
      footerContent: [
        {
          text: 'Buildteam',
          href: 'https://buildteamworld.slack.com/archives/CD6HZC750',
          icon: { slack: {} },
        },
      ],
    },
  },

}
