local simpledash = import '../lib/simpledash.libsonnet';

local services = [
  'CompactLogs',
  'LockInvocationsWithNoRecentEvents',
  'RemoveBuildsWithoutInvocations',
  'RemoveInactiveUsers',
  'RemoveIncompleteLogs',
  'RemoveOldInvocations',
  'RemoveOrphanedTestTargets',
  'RemoveTargetKindMappings',
  'RemoveUnusedDigests',
  'RemoveUnusedFilePaths',
  'RemoveUnusedFiles',
  'RemoveUnusedTargets',
  'UpdateInvocationEndedAtFromEvents',
];

{
  dashboards+:: {
    'bb-portal-cleanup-service.json': simpledash.dashboard(
      title='BB Portal Cleanup Service',
      templates=[],
      rows=[
        simpledash.graph(
          title='Duration',
          width=1,
          stacking=simpledash.stackingDisabled,
          unit=simpledash.unitSeconds,
          targets=[
            simpledash.graphTarget(
              expr='sum(increase(buildbarn_portal_cleanup_service_duration_seconds_total{%s="$cluster"}[$__rate_interval]) > 0) by (Service)' % $._config.clusterLabel,
              legendFormat='{{Service}}'
            ),
          ],
          interval='1m'
        ),
      ] + [
        simpledash.row(
          title=service,
          panels=[
            simpledash.graph(
              title='Duration',
              width=1 / 2,
              stacking=simpledash.stackingDisabled,
              unit=simpledash.unitSeconds,
              targets=[
                simpledash.graphTarget(
                  expr='sum(increase(buildbarn_portal_cleanup_service_duration_seconds_total{Service="%s", %s="$cluster"}[$__rate_interval]) > 0)' % [service, $._config.clusterLabel],
                  legendFormat='Service run duration'
                ),
              ],
              interval='1m'
            ),
            simpledash.graph(
              title='Volume',
              width=1 / 2,
              stacking=simpledash.stackingDisabled,
              unit=simpledash.unitNone,
              targets=[
                simpledash.graphTarget(
                  expr='sum(increase(buildbarn_portal_cleanup_service_volume_total{Service="%s", %s="$cluster"}[$__rate_interval]))' % [service, $._config.clusterLabel],
                  legendFormat='Service run volume'
                ),
              ],
              interval='1m'
            ),
          ]
        )
        for service in services
      ],
      config=$._config,
    ),
  },
}
