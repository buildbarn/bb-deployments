local simpledash = import '../lib/simpledash.libsonnet';

{
  dashboards+:: {
    'bb-portal-overview.json': simpledash.dashboard(
      'BB Portal Overview',
      templates=[],
      rows=[
        simpledash.stat(
          title='Unique authenticated users',
          width=1 / 3,
          targets=[simpledash.statTarget(
            expr='max(buildbarn_portal_authenticated_user_count{%s="$cluster"})' % $._config.clusterLabel,
            instant=true,
          )],
          unit=simpledash.unitNone
        ),
        simpledash.graph(
          title='Rate of invocations by Authentication Status',
          width=1 / 3,
          stacking=simpledash.stackingDisabled,
          unit=simpledash.unitNone,
          targets=[
            simpledash.graphTarget(
              expr='max(delta(buildbarn_portal_invocations{%s="$cluster"}[$__rate_interval])) by (AuthStatus)' % $._config.clusterLabel,
              legendFormat='{{AuthStatus}}',
            ),
          ],
          interval='1m'
        ),
        simpledash.graph(
          title='Invocations by authentication status',
          width=1 / 3,
          stacking=simpledash.stackingDisabled,
          unit=simpledash.unitNone,
          targets=[
            simpledash.graphTarget(
              expr='sum(max(buildbarn_portal_invocations{%s="$cluster"}) by (AuthStatus)) by (AuthStatus)' % $._config.clusterLabel,
              legendFormat='{{AuthStatus}}',
            ),
          ],
        ),

        simpledash.graph(
          title='Event processing speed',
          width=1 / 3,
          stacking=simpledash.stackingDisabled,
          unit=simpledash.unitSeconds,
          targets=[
            simpledash.graphTarget(
              expr='sum(rate(buildbarn_portal_build_event_recorder_save_batch_duration_seconds_sum{%s="$cluster"}[1m])) / sum(rate(buildbarn_portal_build_event_recorder_save_batch_size_sum{%s="$cluster"}[1m]))' % [$._config.clusterLabel, $._config.clusterLabel],
              legendFormat='Seconds Per Event'
            ),
          ],
        ),
        simpledash.graph(
          title='In Flight Streams',
          width=1 / 3,
          stacking=simpledash.stackingDisabled,
          unit=simpledash.unitNone,
          targets=[
            simpledash.graphTarget(
              expr='grpc_method_grpc_service_kubernetes_service:grpc_server_in_flight:sum{kubernetes_service="bb-portal", grpc_method="PublishBuildToolEventStream", %s="$cluster"}' % $._config.clusterLabel,
              legendFormat='Streams'
            ),
          ],
        ),
        simpledash.graph(
          title='Events per second [5m]',
          width=1 / 3,
          stacking=simpledash.stackingDisabled,
          unit=simpledash.unitNone,
          targets=[
            simpledash.graphTarget(
              expr='sum by(status) (rate(buildbarn_portal_build_event_recorder_save_batch_size_sum{%s="$cluster"}[5m]))' % $._config.clusterLabel,
              legendFormat='{{status}}'
            ),
          ],
        ),

        simpledash.heatmap(
          title='Batch Size Distribution',
          width=1 / 2,
          unit=simpledash.unitNone,
          targets=[
            simpledash.heatmapTarget(
              expr='sum(increase(buildbarn_portal_build_event_recorder_save_batch_size_bucket{%s="$cluster"}[$__rate_interval])) by (le)' % $._config.clusterLabel,
            ),
          ],
          interval='1m'
        ),
        simpledash.heatmap(
          title='Batch Duration Distribution',
          width=1 / 2,
          unit=simpledash.unitNone,
          targets=[
            simpledash.heatmapTarget(
              expr='sum(increase(buildbarn_portal_build_event_recorder_save_batch_duration_seconds_bucket{%s="$cluster"}[$__rate_interval])) by (le)' % $._config.clusterLabel,
            ),
          ],
          interval='1m'
        ),

        simpledash.graph(
          title='Batch Size Distribution',
          width=1 / 2,
          stacking=simpledash.stackingDisabledLogarithmic { scaleDistribution+: { log: 2 } },
          unit=simpledash.unitNone,
          targets=[
            simpledash.graphTarget(
              expr='histogram_quantile(0.25, sum by(le) (increase(buildbarn_portal_build_event_recorder_save_batch_size_bucket{%s="$cluster"}[5m])))' % $._config.clusterLabel,
              legendFormat='P25'
            ),
            simpledash.graphTarget(
              expr='histogram_quantile(0.5, sum by(le) (increase(buildbarn_portal_build_event_recorder_save_batch_size_bucket{%s="$cluster"}[5m])))' % $._config.clusterLabel,
              legendFormat='P50'
            ),
            simpledash.graphTarget(
              expr='histogram_quantile(0.75, sum by(le) (increase(buildbarn_portal_build_event_recorder_save_batch_size_bucket{%s="$cluster"}[5m])))' % $._config.clusterLabel,
              legendFormat='P75'
            ),
          ],
        ),
        simpledash.graph(
          title='Batch Duration Distribution',
          width=1 / 2,
          stacking=simpledash.stackingDisabledLogarithmic { scaleDistribution+: { log: 2 } },
          unit=simpledash.unitSeconds,
          targets=[
            simpledash.graphTarget(
              expr='histogram_quantile(0.95, sum by(le) (increase(buildbarn_portal_build_event_recorder_save_batch_duration_seconds_bucket{%s="$cluster"}[5m])))' % $._config.clusterLabel,
              legendFormat='P95'
            ),
            simpledash.graphTarget(
              expr='histogram_quantile(0.99, sum by(le) (increase(buildbarn_portal_build_event_recorder_save_batch_duration_seconds_bucket{%s="$cluster"}[5m])))' % $._config.clusterLabel,
              legendFormat='P99'
            ),
          ],
        ),
      ],
      config=$._config,
    ),
  },
}
