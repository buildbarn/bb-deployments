local blobstore = import 'blobstore.jsonnet';
local vars = import 'vars.jsonnet';

{
  blobstore: blobstore.client_blobstore,
  browser_url: 'http://' + vars.browser_http_address,
  build_directory_path: 'build',
  cache_directory_path: 'cache',
  concurrency: 4,
  runner_address: 'unix://runner',
  scheduler_address: vars.scheduler_grpc_address,
  metrics_listen_address: vars.worker_http_metrics_address,
}
