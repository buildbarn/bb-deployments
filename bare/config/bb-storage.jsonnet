local blobstore = import 'blobstore.jsonnet';
local vars = import 'vars.jsonnet';

{
  blobstore: blobstore.serverBlobstore,
  metricsListenAddress: vars.storageMetricsAddress,
  schedulers: {
    'local': vars.schedulerAddress,
  },
  allowAcUpdatesForInstances: ['bb-event-service', 'local'],
}
