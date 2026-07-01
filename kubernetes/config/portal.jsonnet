local common = import 'common.libsonnet';

{
  global: common.global,

  httpServers: [{
    listenAddresses: [':8081'],
    authenticationPolicy: { allow: {} },
  }],

  instanceNameAuthorizer: {
    allow: {},
  },

  maximumMessageSizeBytes: common.maximumMessageSizeBytes,

  besServiceConfiguration: {
    grpcServers: [{
      listenAddresses: [':8082'],
      authenticationPolicy: { allow: {} },
      maximumReceivedMessageSizeBytes: 10 * 1024 * 1024,
    }],
    database: {
      postgres: {
        connectionString: 'postgresql://app:password@postgres:5432/app',
      },
      connectionPoolConfiguration: {
        maxOpenConnections: 10,
        maxIdleConnections: 10,
        connectionMaxLifetime: '120s',
        connectionMaxIdleTime: '30s',
      },
    },
    enableBepFileUpload: true,
    enableGraphqlPlayground: true,
    saveDataLevel: { basicAndTarget: {} },
    databaseCleanupConfiguration: {
      cleanupInterval: '60s',
      invocationMessageTimeout: '3600s',
      invocationRetention: '604800s',
    },
    minEventBatchDuration: '0.1s',
    buildKey: 'build_id',
  },

  contentAddressableStorage: common.blobstore.contentAddressableStorage,
  actionCache: common.blobstore.contentAddressableStorage,
  initialSizeClassCache: common.blobstore.contentAddressableStorage,
  fileSystemAccessCache: common.blobstore.contentAddressableStorage,

  schedulerServiceConfiguration: {
    buildQueueStateClient: {
      address: 'scheduler:8984',
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
        home: {
          fileUpload: {},
          instructions: {},
        },
        bes: {
          pageBuilds: {},
          pageInvocations: {},
          pageTargets: {},
          pageTests: {},
          pageTrends: {},
        },
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
