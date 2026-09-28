local common = import 'common.libsonnet';

{
  global: common.global,
  httpServers: [{
    listenAddresses: [':8081'],
    authenticationPolicy: { allow: {} },
  }],
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
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
    cleanupConfiguration: {
      cleanupInterval: '60s',
      invocationMessageTimeout: '3600s',
      invocationRetention: '604800s',
      completedActionRetention: '604800s',
    },
  },
  besServiceConfiguration: {
    grpcServers: [{
      listenAddresses: [':8082'],
      authenticationPolicy: { allow: {} },
      maximumReceivedMessageSizeBytes: 10 * 1024 * 1024,
    }],
    publishAuthorizer: { allow: {} },
    enableBepFileUpload: true,
    saveDataLevel: { basicAndTarget: {} },
    minEventBatchDuration: '0.1s',
    buildKey: 'build_id',
  },
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
      address: 'scheduler:8984',
    },
    killOperationsAuthorizer: {
      allow: {},
    },
    listOperationsPageSize: 500,
    readAuthorizer: { allow: {} },
  },
  graphqlApiServiceConfiguration: {
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
