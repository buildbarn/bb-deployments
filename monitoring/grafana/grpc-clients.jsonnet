local grpc = import 'monitoring/grafana/grpc.libsonnet';
local simpledash = import 'monitoring/grafana/simpledash.libsonnet';

simpledash.dashboard(
  title='gRPC clients',
  aggregationPeriods=null,
  templates=grpc.getCommonTemplates('client'),
  rows=grpc.getCommonRows('client'),
)
