local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  listenAddress: ':7984',
}
