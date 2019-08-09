local blobstore = import 'blobstore.jsonnet';
local vars = import 'vars.jsonnet';

{
  blobstore: blobstore.clientBlobstore,
  metricsListenAddress: vars.eventServiceMetricsAddress,
}
