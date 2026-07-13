local simpledash = import '../lib/simpledash.libsonnet';

local storageTypes = ['ac', 'cas', 'icas', 'iscc'];

local showRetentionRow(title, targetMetric, targetLegendFormat, clusterLabel) =
  simpledash.row(
    title=title,
    panels=[
      simpledash.graph(
        title=storageType,
        width=1 / std.length(storageTypes),
        stacking=simpledash.stackingDisabledLogarithmic,
        unit=simpledash.unitSeconds,
        targets=[
          simpledash.graphTarget(
            expr='%s{storage_type="%s",%s="$cluster"}' % [targetMetric, storageType, clusterLabel],
            legendFormat=targetLegendFormat,
          ),
        ],
      )
      for storageType in storageTypes
    ]
  );

{
  dashboards+:: {
    'centralized-storage.json': simpledash.dashboard(
      title='Centralized storage',
      templates=[],
      rows=[
        showRetentionRow(
          title='Per-replica worst shard retention: whether it is safe to restart the other replica',
          targetMetric='kubernetes_replica_storage_type:buildbarn_blobstore_old_current_new_location_blob_map_last_removed_old_block_insertion_time_seconds:min',
          targetLegendFormat='{{kubernetes_replica}}',
          clusterLabel=$._config.clusterLabel,
        ),
        showRetentionRow(
          title='Per-shard best replica retention: amount of data accessible right now',
          targetMetric='kubernetes_shard_storage_type:buildbarn_blobstore_old_current_new_location_blob_map_last_removed_old_block_insertion_time_seconds:max',
          targetLegendFormat='{{kubernetes_shard}}',
          clusterLabel=$._config.clusterLabel,
        ),
        showRetentionRow(
          title='Per-shard worst replica retention: amount of data to remain accessible if a replica were to crash',
          targetMetric='kubernetes_shard_storage_type:buildbarn_blobstore_old_current_new_location_blob_map_last_removed_old_block_insertion_time_seconds:min',
          targetLegendFormat='{{kubernetes_shard}}',
          clusterLabel=$._config.clusterLabel,
        ),

        simpledash.row(
          title='Key-location map: Get()',
          panels=[
            simpledash.graph(
              title=storageType + ' operation rate',
              width=1 / std.length(storageTypes),
              stacking=simpledash.stackingEnabled,
              unit=simpledash.unitOperationsPerSecond,
              targets=[
                simpledash.graphTarget(
                  expr='outcome_storage_type:buildbarn_blobstore_hashing_key_location_map_get_attempts_count:irate1m{storage_type="%s",%s="$cluster"}' % [storageType, $._config.clusterLabel],
                  legendFormat='{{outcome}}',
                ),
                simpledash.graphTarget(
                  expr='storage_type:buildbarn_blobstore_hashing_key_location_map_get_too_many_attempts:irate1m{storage_type="%s",%s="$cluster"}' % [storageType, $._config.clusterLabel],
                  legendFormat='TooManyAttempts',
                ),
              ],
            )
            for storageType in storageTypes
          ] + [
            simpledash.heatmap(
              title=storageType + ' operation attempts',
              width=1 / std.length(storageTypes),
              unit=simpledash.unitNone,
              targets=[
                simpledash.heatmapTarget(
                  expr='le_storage_type:buildbarn_blobstore_hashing_key_location_map_get_attempts_bucket:irate1m{storage_type="%s",%s="$cluster"}' % [storageType, $._config.clusterLabel],
                ),
              ],
            )
            for storageType in storageTypes
          ],
        ),

        simpledash.row(
          title='Key-location map: Put()',
          panels=[
            simpledash.graph(
              title=storageType + ' operation rate',
              width=1 / std.length(storageTypes),
              stacking=simpledash.stackingEnabled,
              unit=simpledash.unitOperationsPerSecond,
              targets=[
                simpledash.graphTarget(
                  expr='storage_type:buildbarn_blobstore_hashing_key_location_map_put_ignored_invalid:irate1m{storage_type="%s",%s="$cluster"}' % [storageType, $._config.clusterLabel],
                  legendFormat='IgnoredInvalid',
                ),
                simpledash.graphTarget(
                  expr='outcome_storage_type:buildbarn_blobstore_hashing_key_location_map_put_iterations_count:irate1m{storage_type="%s",%s="$cluster"}' % [storageType, $._config.clusterLabel],
                  legendFormat='{{outcome}}',
                ),
                simpledash.graphTarget(
                  expr='storage_type:buildbarn_blobstore_hashing_key_location_map_put_too_many_iterations:irate1m{storage_type="%s",%s="$cluster"}' % [storageType, $._config.clusterLabel],
                  legendFormat='TooManyIterations',
                ),
              ],
            )
            for storageType in storageTypes
          ] + [
            simpledash.heatmap(
              title=storageType + ' operation iterations',
              width=1 / std.length(storageTypes),
              unit=simpledash.unitNone,
              targets=[
                simpledash.heatmapTarget(
                  expr='le_storage_type:buildbarn_blobstore_hashing_key_location_map_put_iterations_bucket:irate1m{storage_type="%s",%s="$cluster"}' % [storageType, $._config.clusterLabel],
                ),
              ],
            )
            for storageType in storageTypes
          ],
        ),
      ],
      config=$._config,
    ),
  },
}
