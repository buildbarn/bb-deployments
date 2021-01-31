local simpledash = import 'monitoring/grafana/simpledash.libsonnet';

local show_row(title, create_graph) =
  simpledash.row(
    title=title,
    panels=[
      create_graph('Action Cache', '$ac_backend', 1 / 3),
      create_graph('Content Addressable Storage', '$cas_backend', 1 / 3),
      create_graph('Indirect Content Addressable Storage', '$icas_backend', 1 / 3),
    ]
  );

simpledash.dashboard(
  title='BlobAccess',
  templates=[
    simpledash.template(
      name='ac_backend',
      query='label_values(kubernetes_service_name_operation:buildbarn_blobstore_blob_access_operations_started:irate1m{name=~"ac.*"}, name)',
      label='Action Cache backend',
      selectionStyle=simpledash.selectSingleWithDefault('ac_grpc'),
    ),
    simpledash.template(
      name='cas_backend',
      query='label_values(kubernetes_service_name_operation:buildbarn_blobstore_blob_access_operations_started:irate1m{name=~"cas.*"}, name)',
      label='Content Addressable Storage backend',
      selectionStyle=simpledash.selectSingleWithDefault('cas_grpc'),
    ),
    simpledash.template(
      name='icas_backend',
      query='label_values(kubernetes_service_name_operation:buildbarn_blobstore_blob_access_operations_started:irate1m{name=~"icas.*"}, name)',
      label='Indirect Content Addressable Storage backend',
      selectionStyle=simpledash.selectSingleWithDefault('icas_grpc'),
    ),
    simpledash.template(
      name='kubernetes_service',
      query='label_values(kubernetes_service_name_operation:buildbarn_blobstore_blob_access_operations_started:irate1m, kubernetes_service)',
      label='Service name',
      selectionStyle=simpledash.selectMultiple,
    ),
  ],
  aggregationPeriods=null,
  rows=[
    show_row(
      title='Operation rate by operation',
      create_graph=function(title, backend, width) simpledash.graph(
        title=title,
        width=width,
        stacking=simpledash.stackingEnabled,
        unit=simpledash.unitOperationsPerSecond,
        targets=[
          simpledash.graphTarget(
            expr='sum(kubernetes_service_name_operation:buildbarn_blobstore_blob_access_operations_started:irate1m{kubernetes_service=~"$kubernetes_service",name=~"%s"}) by (operation)' % backend,
            legendFormat='{{operation}}',
          ),
        ],
      ),
    ),
    show_row(
      title='Operation rate by gRPC status code',
      create_graph=function(title, backend, width) simpledash.graph(
        title=title,
        width=width,
        stacking=simpledash.stackingEnabled,
        unit=simpledash.unitOperationsPerSecond,
        targets=[
          simpledash.graphTarget(
            expr='sum(grpc_code_kubernetes_service_name:buildbarn_blobstore_blob_access_operations_duration_seconds_count:irate1m{kubernetes_service=~"$kubernetes_service",name=~"%s"}) by (grpc_code)' % backend,
            legendFormat='{{grpc_code}}',
          ),
        ],
      ),
    ),
  ] + [
    show_row(
      title=operation + '() duration',
      create_graph=function(title, backend, width) simpledash.heatmap(
        title=title,
        width=width,
        unit=simpledash.unitDurationSeconds,
        targets=[
          simpledash.heatmapTarget(
            expr='sum(kubernetes_service_le_name_operation:buildbarn_blobstore_blob_access_operations_duration_seconds_bucket:irate1m{kubernetes_service=~"$kubernetes_service",name=~"%s",operation="%s"}) by (le)' % [backend, operation],
          ),
        ],
      ),
    )
    for operation in ['Get', 'Put', 'FindMissing']
  ] + [
    show_row(
      title=operation + '() object size',
      create_graph=function(title, backend, width) simpledash.heatmap(
        title=title,
        width=width,
        unit=simpledash.unitBytes,
        targets=[
          simpledash.heatmapTarget(
            expr='sum(kubernetes_service_le_name_operation:buildbarn_blobstore_blob_access_operations_blob_size_bytes_bucket:irate1m{kubernetes_service=~"$kubernetes_service",name=~"%s",operation="%s"}) by (le)' % [backend, operation],
          ),
        ],
      ),
    )
    for operation in ['Get', 'Put']
  ] + [
    show_row(
      title='FindMissing() batch size',
      create_graph=function(title, backend, width) simpledash.heatmap(
        title=title,
        width=width,
        unit=simpledash.unitNone,
        targets=[
          simpledash.heatmapTarget(
            expr='sum(kubernetes_service_le_name:buildbarn_blobstore_blob_access_operations_find_missing_batch_size_bucket:irate1m{kubernetes_service=~"$kubernetes_service",name=~"%s"}) by (le)' % backend,
          ),
        ],
      ),
    ),
  ],
)
