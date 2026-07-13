local grpc = import '../lib/grpc.libsonnet';
local simpledash = import '../lib/simpledash.libsonnet';

{
  dashboards+:: {
    'grpc-clients.json': simpledash.dashboard(
      title='gRPC clients',
      templates=grpc.getCommonTemplates('client'),
      rows=grpc.getCommonRows('client', $._config),
      config=$._config,
    ),
  },
}
