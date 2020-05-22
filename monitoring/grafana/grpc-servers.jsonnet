local grpc = import 'monitoring/grafana/grpc.libsonnet';
local simpledash = import 'monitoring/grafana/simpledash.libsonnet';

simpledash.dashboard(
  title='gRPC servers',
  aggregationPeriods=null,
  templates=grpc.getCommonTemplates('server'),
  rows=grpc.getCommonRows('server'),
)
