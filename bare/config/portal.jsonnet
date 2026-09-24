local common = import 'common.libsonnet';

{
  // besServiceConfiguration is disabled as it requires a Postgres instance.
  global: common.globalWithDiagnosticsHttpServer(':9983'),
  httpServers: [{
    listenAddresses: [':8081'],
    authenticationPolicy: { allow: {} },
  }],
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  contentAddressableStorage: {
    backend: common.blobstore.contentAddressableStorage,
    readAuthorizer: { allow: {} },
  },
  actionCache: {
    backend: common.blobstore.actionCache,
    readAuthorizer: { allow: {} },
  },
  initialSizeClassCache: {
    backend: common.initialSizeClassCache,
    readAuthorizer: { allow: {} },
  },
  fileSystemAccessCache: {
    backend: common.fileSystemAccessCache,
    readAuthorizer: { allow: {} },
  },
  blobstoreServiceConfiguration: {},
  schedulerServiceConfiguration: {
    buildQueueStateClient: {
      address: 'localhost:8984',
    },
    killOperationsAuthorizer: {
      allow: {},
    },
    listOperationsPageSize: 500,
    readAuthorizer: { allow: {} },
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
