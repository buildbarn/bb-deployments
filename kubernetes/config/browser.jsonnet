local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  httpServers: [{
    listenAddresses: [':7984'],
    authenticationPolicy: { allow: {} },
  }],
  global: common.global,
  authorizer: { allow: {} },
  requestMetadataLinksJmespathExpression: { expression: '`{}`' },
}
