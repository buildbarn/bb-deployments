local simpledash = import 'simpledash.libsonnet';

{
  getCommonTemplates(side): [
    simpledash.template(
      name='grpc_service',
      query='label_values(grpc_code_grpc_method_grpc_service_kubernetes_service:grpc_%s_handled:irate1m, grpc_service)' % side,
      label='gRPC service name',
      selectionStyle=simpledash.selectMultiple,
    ),
    simpledash.template(
      name='grpc_method',
      query='label_values(grpc_code_grpc_method_grpc_service_kubernetes_service:grpc_%s_handled:irate1m, grpc_method)' % side,
      label='gRPC method name',
      selectionStyle=simpledash.selectMultiple,
    ),
    simpledash.template(
      name='grpc_code',
      query='label_values(grpc_code_grpc_method_grpc_service_kubernetes_service:grpc_%s_handled:irate1m, grpc_code)' % side,
      label='gRPC status code',
      selectionStyle=simpledash.selectMultiple,
    ),
    simpledash.template(
      name='kubernetes_service',
      query='label_values(grpc_code_grpc_method_grpc_service_kubernetes_service:grpc_%s_handled:irate1m, kubernetes_service)' % side,
      label='Kubernetes service name',
      selectionStyle=simpledash.selectMultiple,
    ),
  ],

  local getSimpleRow(title, unit, metric) =
    simpledash.row(
      title=title,
      panels=[
        simpledash.graph(
          title='By gRPC method',
          width=1 / 2,
          stacking=simpledash.stackingEnabled,
          unit=unit,
          targets=[
            simpledash.graphTarget(
              expr='sum(%s{grpc_method=~"$grpc_method",grpc_service=~"$grpc_service",kubernetes_service=~"$kubernetes_service"}) by (grpc_service, grpc_method)' % metric,
              legendFormat='{{grpc_service}}.{{grpc_method}}',
            ),
          ],
        ),
        simpledash.graph(
          title='By Kubernetes service',
          width=1 / 2,
          stacking=simpledash.stackingEnabled,
          unit=unit,
          targets=[
            simpledash.graphTarget(
              expr='sum(%s{grpc_method=~"$grpc_method",grpc_service=~"$grpc_service",kubernetes_service=~"$kubernetes_service"}) by (kubernetes_service)' % metric,
              legendFormat='{{kubernetes_service}}',
            ),
          ],
        ),
      ],
    ),

  getCommonRows(side): [
    getSimpleRow(
      title='Number of in-flight operations',
      unit=simpledash.unitNone,
      metric='grpc_method_grpc_service_kubernetes_service:grpc_%s_in_flight:sum' % side
    ),

    simpledash.row(
      title='Operation rate',
      panels=[
        simpledash.graph(
          title='By gRPC method',
          width=1 / 3,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr='sum(grpc_code_grpc_method_grpc_service_kubernetes_service:grpc_%s_handled:irate1m{grpc_code=~"$grpc_code",grpc_method=~"$grpc_method",grpc_service=~"$grpc_service",kubernetes_service=~"$kubernetes_service"}) by (grpc_service, grpc_method)' % side,
              legendFormat='{{grpc_service}}.{{grpc_method}}',
            ),
          ],
        ),
        simpledash.graph(
          title='By gRPC status code',
          width=1 / 3,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr='sum(grpc_code_grpc_method_grpc_service_kubernetes_service:grpc_%s_handled:irate1m{grpc_code=~"$grpc_code",grpc_code=~"$grpc_code",grpc_method=~"$grpc_method",grpc_service=~"$grpc_service",kubernetes_service=~"$kubernetes_service"}) by (grpc_code)' % side,
              legendFormat='{{grpc_code}}',
            ),
          ],
        ),
        simpledash.graph(
          title='By Kubernetes service',
          width=1 / 3,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr='sum(grpc_code_grpc_method_grpc_service_kubernetes_service:grpc_%s_handled:irate1m{grpc_code=~"$grpc_code",grpc_method=~"$grpc_method",grpc_service=~"$grpc_service",kubernetes_service=~"$kubernetes_service"}) by (kubernetes_service)' % side,
              legendFormat='{{kubernetes_service}}',
            ),
          ],
        ),
      ],
    ),

    getSimpleRow(
      title='Messages sent',
      unit=simpledash.unitWritesPerSecond,
      metric='grpc_method_grpc_service_kubernetes_service:grpc_%s_msg_sent:irate1m' % side
    ),
    getSimpleRow(
      title='Messages received',
      unit=simpledash.unitReadsPerSecond,
      metric='grpc_method_grpc_service_kubernetes_service:grpc_%s_msg_received:irate1m' % side
    ),

    simpledash.row(
      title='Timing',
      panels=[
        simpledash.heatmap(
          title='RPC duration',
          width=1,
          unit=simpledash.unitDurationSeconds,
          targets=[
            simpledash.heatmapTarget(
              expr='sum(grpc_method_grpc_service_kubernetes_service_le:grpc_%s_handling_seconds_bucket:irate1m{grpc_method=~"$grpc_method",grpc_service=~"$grpc_service",kubernetes_service=~"$kubernetes_service"}) by (le)' % side,
            ),
          ],
        ),
      ],
    ),
  ],
}
