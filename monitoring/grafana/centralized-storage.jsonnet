local simpledash = import 'monitoring/grafana/simpledash.libsonnet';

local backendTypes = ['ac', 'cas'];

local showRetentionRow(title, targetMetric, targetLegendFormat) =
  simpledash.row(
    title=title,
    panels=[
      simpledash.graph(
        title=backend,
        width=1 / 2,
        stacking=simpledash.stackingDisabledLogarithmic,
        unit=simpledash.unitSeconds,
        targets=[
          simpledash.graphTarget(
            expr='%s{name="%s"}' % [targetMetric, backend],
            legendFormat=targetLegendFormat,
          ),
        ],
      )
      for backend in backendTypes
    ]
  );

simpledash.dashboard(
  title='Centralized storage',
  aggregationPeriods=null,
  templates=[],
  rows=[
    showRetentionRow(
      title='Per-replica worst shard retention: whether it is safe to restart the other replica',
      targetMetric='kubernetes_replica_name:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds:min',
      targetLegendFormat='{{kubernetes_replica}}',
    ),
    showRetentionRow(
      title='Per-shard best replica retention: amount of data accessible right now',
      targetMetric='kuberentes_shard_name:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds:max',
      targetLegendFormat='{{kubernetes_shard}}',
    ),
    showRetentionRow(
      title='Per-shard worst replica retention: amount of data to remain accessible if a replica were to crash',
      targetMetric='kuberentes_shard_name:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds:min',
      targetLegendFormat='{{kubernetes_shard}}',
    ),

    simpledash.row(
      title='Key-location map: Get()',
      panels=[
        simpledash.graph(
          title=backend + ' operation rate',
          width=1 / 2,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr='name_outcome:buildbarn_blobstore_hashing_key_location_map_get_attempts_count:irate1m{name="%s"}' % backend,
              legendFormat='{{outcome}}',
            ),
            simpledash.graphTarget(
              expr='name:buildbarn_blobstore_hashing_key_location_map_get_too_many_attempts:irate1m{name="%s"}' % backend,
              legendFormat='TooManyAttempts',
            ),
          ],
        )
        for backend in backendTypes
      ] + [
        simpledash.heatmap(
          title=backend + ' operation attempts',
          width=1 / 2,
          unit=simpledash.unitNone,
          targets=[
            simpledash.heatmapTarget(
              expr='le_name:buildbarn_blobstore_hashing_key_location_map_get_attempts_bucket:irate1m{name="%s"}' % backend,
            ),
          ],
        )
        for backend in backendTypes
      ],
    ),

    simpledash.row(
      title='Key-location map: Put()',
      panels=[
        simpledash.graph(
          title=backend + ' operation rate',
          width=1 / 2,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr='name:buildbarn_blobstore_hashing_key_location_map_put_ignored_invalid:irate1m{name="%s"}' % backend,
              legendFormat='IgnoredInvalid',
            ),
            simpledash.graphTarget(
              expr='name_outcome:buildbarn_blobstore_hashing_key_location_map_put_iterations_count:irate1m{name="%s"}' % backend,
              legendFormat='{{outcome}}',
            ),
            simpledash.graphTarget(
              expr='name:buildbarn_blobstore_hashing_key_location_map_put_too_many_iterations:irate1m{name="%s"}' % backend,
              legendFormat='TooManyIterations',
            ),
          ],
        )
        for backend in backendTypes
      ] + [
        simpledash.heatmap(
          title=backend + ' operation iterations',
          width=1 / 2,
          unit=simpledash.unitNone,
          targets=[
            simpledash.heatmapTarget(
              expr='le_name:buildbarn_blobstore_hashing_key_location_map_put_iterations_bucket:irate1m{name="%s"}' % backend,
            ),
          ],
        )
        for backend in backendTypes
      ],
    ),
  ],
)
