local simpledash = import 'monitoring/grafana/simpledash.libsonnet';

local prettifyPlatform(expr) =
  local numReplacements = 5;
  (
    // Replace '{"name":"foo","value":"bar"}' with 'foo=bar' numReplacements times.
    // '{"name":"foo"}' is replaced with 'foo='.
    // The first call strips '{"properties":[' from the start and ']}' from the end,
    // the other calls strip the comma that is separating each field.
    std.repeat('label_replace(', numReplacements) + '\n' + expr +
    '\n,"platform","$1=$3$4","platform",\'{"properties":\\\\[{"name":"([^"]*)"(,"value":"([^"]*)")?}(.*)]}\')' +
    std.repeat('\n,"platform","$1 $2=$4$5","platform",\'(.*),{"name":"([^"]*)"(,"value":"([^"]*)")?}(.*)\')', numReplacements - 1)
  );

simpledash.dashboard(
  title='BB Scheduler',
  templates=[
    simpledash.template(
      name='instance_name_prefix',
      query='label_values(instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_queued:irate1m, instance_name_prefix)',
      label='Instance name',
      selectionStyle=simpledash.selectMultiple,
    ),
    // Platform properties contains double quotes, so the regex patterns
    // need to be single quoted as Grafana doesn't escape double quotes
    // in regex patterns properly. Therefore, to be explicit,
    // `platform=~\'$platform\'` is used in the expressions below.
    simpledash.template(
      name='platform',
      query='label_values(instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_queued:irate1m, platform)',
      // Strip the '{"properties":' part as that exists in all the entries.
      regex='/(?<value>{"properties":\\[(?<text>.*)\\]})/',
      label='Platform',
      selectionStyle=simpledash.selectMultiple,
    ),
  ],
  aggregationPeriods=null,
  rows=[
    // How many tasks are being moved through the scheduler.
    simpledash.row(
      title='Task rate by stage transition',
      panels=[
        simpledash.graph(
          title='Nonexistent → Queued',
          width=1 / 4,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr=prettifyPlatform('instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_queued:irate1m{instance_name_prefix=~"$instance_name_prefix",platform=~\'$platform\'}'),
              legendFormat='{{instance_name_prefix}} [{{platform}}] {{size_class}}',
            ),
          ],
        ),
        simpledash.graph(
          title='Queued → Executing',
          width=1 / 4,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr=prettifyPlatform('instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_executing:irate1m{instance_name_prefix=~"$instance_name_prefix",platform=~\'$platform\'}'),
              legendFormat='{{instance_name_prefix}} [{{platform}}] {{size_class}}',
            ),
          ],
        ),
        simpledash.graph(
          title='Executing → Completed',
          width=1 / 4,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr=prettifyPlatform('grpc_code_instance_name_prefix_platform_result_size_class:buildbarn_builder_in_memory_build_queue_tasks_completed:irate1m{instance_name_prefix=~"$instance_name_prefix",platform=~\'$platform\'}'),
              legendFormat='{{instance_name_prefix}} [{{platform}}] {{size_class}} {{result}} {{grpc_code}}',
            ),
          ],
        ),
        simpledash.graph(
          title='Completed → Removed',
          width=1 / 4,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitOperationsPerSecond,
          targets=[
            simpledash.graphTarget(
              expr=prettifyPlatform('instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_removed:irate1m{instance_name_prefix=~"$instance_name_prefix",platform=~\'$platform\'}'),
              legendFormat='{{instance_name_prefix}} [{{platform}}] {{size_class}}',
            ),
          ],
        ),
      ]
    ),

    // How many tasks are present within the scheduler.
    simpledash.row(
      title='Task count by stage',
      panels=[
        simpledash.graph(
          title=stage,
          width=1 / 3,
          stacking=simpledash.stackingEnabled,
          unit=simpledash.unitNone,
          targets=[
            simpledash.graphTarget(
              expr=prettifyPlatform('instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_%s:sum{instance_name_prefix=~"$instance_name_prefix",platform=~\'$platform\'}' % std.asciiLower(stage)),
              legendFormat='{{instance_name_prefix}} [{{platform}}] {{size_class}}',
            ),
          ],
        )
        for stage in ['Queued', 'Executing', 'Completed']
      ],
    ),

    // How long tasks spend within the scheduler.
    simpledash.row(
      title='Task duration by stage',
      panels=[
        simpledash.heatmap(
          title=stage,
          width=1 / 3,
          unit=simpledash.unitDurationSeconds,
          targets=[
            simpledash.heatmapTarget(
              expr='sum(instance_name_prefix_le_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_%s_duration_seconds_bucket:irate1m{instance_name_prefix=~"$instance_name_prefix",platform=~\'$platform\'}) by (le)' % std.asciiLower(stage),
            ),
          ],
        )
        for stage in ['Queued', 'Executing', 'Completed']
      ],
    ),

    simpledash.row(
      title='Miscellaneous',
      panels=[
        simpledash.heatmap(
          title='Task execution retries',
          width=1,
          unit=simpledash.unitNone,
          targets=[
            simpledash.heatmapTarget(
              expr='sum(instance_name_prefix_le_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_executing_retries_bucket:irate1m{instance_name_prefix=~"$instance_name_prefix",platform=~\'$platform\'}) by (le)',
            ),
          ],
        ),
      ],
    ),
  ],
)
