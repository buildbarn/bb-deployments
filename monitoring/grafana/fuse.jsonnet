local simpledash = import 'monitoring/grafana/simpledash.libsonnet';

simpledash.dashboard(
  title='FUSE',
  templates=[
    simpledash.template(
      name='kubernetes_service',
      query='label_values(kubernetes_service_operation_status_code:buildbarn_fuse_raw_file_system_operations_duration_seconds_count:irate1m, kubernetes_service)',
      label='Service name',
      selectionStyle=simpledash.selectMultiple,
    ),
    simpledash.template(
      name='operation',
      query='label_values(kubernetes_service_operation_status_code:buildbarn_fuse_raw_file_system_operations_duration_seconds_count:irate1m, operation)',
      label='FUSE operation',
      selectionStyle=simpledash.selectMultiple,
    ),
    simpledash.template(
      name='callback',
      query='label_values(callback_kubernetes_service_status_code:buildbarn_fuse_raw_file_system_callbacks:irate1m, callback)',
      label='FUSE callback',
      selectionStyle=simpledash.selectMultiple,
    ),
    simpledash.template(
      name='status_code',
      query='label_values(status_code:buildbarn_fuse_raw_file_system_callbacks_and_operations:irate1m, status_code)',
      label='Status code',
      selectionStyle=simpledash.selectMultiple,
    ),
  ],
  aggregationPeriods=null,
  rows=[
    simpledash.row(
      title='Operation rate',
      panels=[
        simpledash.graph(
          title='By ' + aggregation[1],
          width=1 / 3,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr='sum(kubernetes_service_operation_status_code:buildbarn_fuse_raw_file_system_operations_duration_seconds_count:irate1m{kubernetes_service=~"$kubernetes_service",operation=~"$operation",status_code=~"$status_code"}) by (%s)' % aggregation[0],
              legendFormat='{{%s}}' % aggregation[0],
            ),
          ],
        )
        for aggregation in [
          ['kubernetes_service', 'Kubernetes service'],
          ['operation', 'FUSE operation'],
          ['status_code', 'status code'],
        ]
      ]
    ),
    simpledash.row(
      title='Operation duration',
      panels=[
        simpledash.heatmap(
          title='Operation duration',
          width=1,
          unit=simpledash.unitDurationSeconds,
          targets=[
            simpledash.heatmapTarget(
              expr='sum(kubernetes_service_le_operation_status_code:buildbarn_fuse_raw_file_system_operations_duration_seconds_bucket:irate1m{kubernetes_service=~"$kubernetes_service",operation=~"$operation",status_code=~"$status_code"}) by (le)',
            ),
          ],
        ),
      ],
    ),

    simpledash.row(
      title='Callback rate',
      panels=[
        simpledash.graph(
          title='By ' + aggregation[1],
          width=1 / 3,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr='sum(callback_kubernetes_service_status_code:buildbarn_fuse_raw_file_system_callbacks:irate1m{callback=~"$callback",kubernetes_service=~"$kubernetes_service",status_code=~"$status_code"}) by (%s)' % aggregation[0],
              legendFormat='{{%s}}' % aggregation[0],
            ),
          ],
        )
        for aggregation in [
          ['kubernetes_service', 'Kubernetes service'],
          ['callback', 'FUSE callback'],
          ['status_code', 'status code'],
        ]
      ]
    ),
  ]
)
