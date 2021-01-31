local simpledash = import 'monitoring/grafana/simpledash.libsonnet';

simpledash.dashboard(
  title='Eviction sets',
  templates=[
    simpledash.template(
      name='kubernetes_service',
      query='label_values(kubernetes_service_name_operation:buildbarn_eviction_set_operations:rate1h, kubernetes_service)',
      label='Service name',
      selectionStyle=simpledash.selectMultiple,
    ),
  ],
  aggregationPeriods=null,
  rows=[
    simpledash.row(
      title=set,
      panels=[
        simpledash.graph(
          title='Operation rate',
          width=1 / 2,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr='sum(kubernetes_service_name_operation:buildbarn_eviction_set_operations:rate1h{kubernetes_service=~"$kubernetes_service",name="%s"}) by (operation)' % set,
              legendFormat='{{operation}}',
            ),
          ],
        ),
        simpledash.graph(
          title='Hit rate = Touch / (Insert + Touch)',
          width=1 / 2,
          stacking=simpledash.stackingDisabled,
          unit=simpledash.unitPercent,
          targets=[
            local operations(operation) = 'sum(kubernetes_service_name_operation:buildbarn_eviction_set_operations:rate1h{name="%s",operation="%s"}) by (kubernetes_service)' % [set, operation];
            simpledash.graphTarget(
              expr='%s / (%s + %s)' % [operations('Touch'), operations('Insert'), operations('Touch')],
              legendFormat='{{kubernetes_service}}',
            ),
          ],
        ),
      ]
    )
    for set in [
      'CachingDirectoryFetcher',
      'DataIntegrityValidationCache',
      'ExistenceCachingBlobAccess',
      'HardlinkingFileFetcher',
      'QueuedBlobReplicator',
    ]
  ]
)
