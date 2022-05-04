local simpledash = import 'monitoring/grafana/simpledash.libsonnet';

local stages = ['FetchingInputs', 'Running', 'UploadingOutputs'];

simpledash.dashboard(
  title='BuildExecutor',
  templates=[
    simpledash.template(
      name='kubernetes_service',
      query='label_values(kubernetes_service:buildbarn_builder_build_executor_operations:irate1m, kubernetes_service)',
      label='Service name',
      selectionStyle=simpledash.selectMultiple,
    ),
  ],
  aggregationPeriods=null,
  rows=[
    simpledash.row(
      title='Operations',
      panels=[
        simpledash.graph(
          title='Operation rate',
          width=1,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr='kubernetes_service:buildbarn_builder_build_executor_operations:irate1m{kubernetes_service=~"$kubernetes_service"}',
              legendFormat='{{kubernetes_service}}',
            ),
          ],
        ),
      ] + [
        simpledash.heatmap(
          title=stage + ' stage duration',
          width=1 / 3,
          unit=simpledash.unitDurationSeconds,
          targets=[
            simpledash.heatmapTarget(
              expr='sum(kubernetes_service_le_stage:buildbarn_builder_build_executor_duration_seconds_bucket:irate1m{kubernetes_service=~"$kubernetes_service",stage="%s"}) by (le)' % stage,
            ),
          ],
        )
        for stage in ['FetchingInputs', 'Running', 'UploadingOutputs']
      ] + [
        simpledash.heatmap(
          title='Virtual execution duration',
          width=1,
          unit=simpledash.unitDurationSeconds,
          targets=[
            simpledash.heatmapTarget(
              expr='sum(kubernetes_service_le:buildbarn_builder_build_executor_virtual_execution_duration_bucket:irate1m{kubernetes_service=~"$kubernetes_service"}) by (le)',
            ),
          ],
        ),
      ]
    ),
    simpledash.row(
      title='POSIX resource usage',
      panels=[
        simpledash.heatmap(
          title=r[0],
          width=r[3],
          unit=r[2],
          targets=[
            simpledash.heatmapTarget(
              expr='sum(kubernetes_service_le:buildbarn_builder_build_executor_posix_%s_bucket:irate1m{kubernetes_service=~"$kubernetes_service"}) by (le)' % r[1],
            ),
          ],
        )
        for r in [
          ['CPU user time', 'user_time', simpledash.unitDurationSeconds, 1 / 2],
          ['CPU system time', 'system_time', simpledash.unitDurationSeconds, 1 / 2],
          ['Maximum resident set size', 'maximum_resident_set_size', simpledash.unitBytes, 1 / 4],
          ['Page reclaims', 'page_reclaims', simpledash.unitNone, 1 / 4],
          ['Page faults', 'page_faults', simpledash.unitNone, 1 / 4],
          ['Swaps', 'swaps', simpledash.unitNone, 1 / 4],
          ['Block input operations', 'block_input_operations', simpledash.unitNone, 1 / 4],
          ['Block output operations', 'block_output_operations', simpledash.unitNone, 1 / 4],
          ['Messages sent', 'messages_sent', simpledash.unitNone, 1 / 4],
          ['Messages received', 'messages_received', simpledash.unitNone, 1 / 4],
          ['Signals received', 'signals_received', simpledash.unitNone, 1 / 3],
          ['Voluntary context switches', 'voluntary_context_switches', simpledash.unitNone, 1 / 3],
          ['Involuntary context switches', 'involuntary_context_switches', simpledash.unitNone, 1 / 3],
        ]
      ],
    ),
    simpledash.row(
      title='File pool resource usage',
      panels=[
        simpledash.heatmap(
          title=r[0],
          width=r[3],
          unit=r[2],
          targets=[
            simpledash.heatmapTarget(
              expr='sum(kubernetes_service_le:buildbarn_builder_build_executor_file_pool_%s_bucket:irate1m{kubernetes_service=~"$kubernetes_service"}) by (le)' % r[1],
            ),
          ],
        )
        for r in [
          ['Files created', 'files_created', simpledash.unitNone, 1 / 3],
          ['Peak file count', 'files_count_peak', simpledash.unitNone, 1 / 3],
          ['Peak file size', 'files_size_bytes_peak', simpledash.unitBytes, 1 / 3],
        ]
      ] + [
        simpledash.heatmap(
          title=r[0],
          width=r[4],
          unit=r[3],
          targets=[
            simpledash.heatmapTarget(
              expr='sum(kubernetes_service_le_operation:buildbarn_builder_build_executor_file_pool_operations_%s_bucket:irate1m{kubernetes_service=~"$kubernetes_service",operation="%s"}) by (le)' % [r[1], r[2]],
            ),
          ],
        )
        for r in [
          ['Read operations', 'count', 'Read', simpledash.unitNone, 1 / 3],
          ['Write operations', 'count', 'Write', simpledash.unitNone, 1 / 3],
          ['Truncate operations', 'count', 'Truncate', simpledash.unitNone, 1 / 3],
          ['Total read size', 'size_bytes', 'Read', simpledash.unitBytes, 1 / 2],
          ['Total write size', 'size_bytes', 'Write', simpledash.unitBytes, 1 / 2],
        ]
      ],
    ),
  ],
)
