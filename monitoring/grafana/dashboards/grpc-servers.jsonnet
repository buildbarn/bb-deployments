local grpc = import '../lib/grpc.libsonnet';
local simpledash = import '../lib/simpledash.libsonnet';

{
  dashboards+:: {
    'grpc-servers.json': simpledash.dashboard(
      title='gRPC servers',
      templates=grpc.getCommonTemplates('server'),
      rows=grpc.getCommonRows('server', $._config),
      config=$._config,
    ),
  },
}
