local simpledash = import 'monitoring/grafana/simpledash.libsonnet';

local show_row(title, create_graph) =
  simpledash.row(
    title=title,
    panels=[
      create_graph('Action Cache', 'ac', 1 / 4),
      create_graph('Content Addressable Storage', 'cas', 1 / 4),
      create_graph('Indirect Content Addressable Storage', 'icas', 1 / 4),
      create_graph('Initial Size Class Cache', 'iscc', 1 / 4),
    ]
  );

simpledash.dashboard(
  title='BlobAccess',
  templates=[
    simpledash.template(
      name='ac_backend_type',
      query='label_values(backend_type_kubernetes_service_operation_storage_type:buildbarn_blobstore_blob_access_operations_started:irate1m{storage_type="ac"}, backend_type)',
      label='Action Cache backend type',
      selectionStyle=simpledash.selectSingleWithDefault('grpc'),
    ),
    simpledash.template(
      name='cas_backend_type',
      query='label_values(backend_type_kubernetes_service_operation_storage_type:buildbarn_blobstore_blob_access_operations_started:irate1m{storage_type="cas"}, backend_type)',
      label='Content Addressable Storage backend type',
      selectionStyle=simpledash.selectSingleWithDefault('grpc'),
    ),
    simpledash.template(
      name='icas_backend_type',
      query='label_values(backend_type_kubernetes_service_operation_storage_type:buildbarn_blobstore_blob_access_operations_started:irate1m{storage_type="icas"}, backend_type)',
      label='Indirect Content Addressable Storage backend type',
      selectionStyle=simpledash.selectSingleWithDefault('grpc'),
    ),
    simpledash.template(
      name='iscc_backend_type',
      query='label_values(backend_type_kubernetes_service_operation_storage_type:buildbarn_blobstore_blob_access_operations_started:irate1m{storage_type="iscc"}, backend_type)',
      label='Initial Size Class Cache backend type',
      selectionStyle=simpledash.selectSingleWithDefault('grpc'),
    ),
    simpledash.template(
      name='kubernetes_service',
      query='label_values(backend_type_kubernetes_service_operation_storage_type:buildbarn_blobstore_blob_access_operations_started:irate1m, kubernetes_service)',
      label='Service name',
      selectionStyle=simpledash.selectMultiple,
    ),
  ],
  aggregationPeriods=null,
  rows=[
    show_row(
      title='Operation rate by operation',
      create_graph=function(title, storageType, width) simpledash.graph(
        title=title,
        width=width,
        stacking=simpledash.stackingEnabled,
        unit=simpledash.unitOperationsPerSecond,
        targets=[
          simpledash.graphTarget(
            expr='sum(backend_type_kubernetes_service_operation_storage_type:buildbarn_blobstore_blob_access_operations_started:irate1m{backend_type=~"$%s_backend_type",kubernetes_service=~"$kubernetes_service",storage_type="%s"}) by (operation)' % [storageType, storageType],
            legendFormat='{{operation}}',
          ),
        ],
      ),
    ),
    show_row(
      title='Operation rate by gRPC status code',
      create_graph=function(title, storageType, width) simpledash.graph(
        title=title,
        width=width,
        stacking=simpledash.stackingEnabled,
        unit=simpledash.unitOperationsPerSecond,
        targets=[
          simpledash.graphTarget(
            expr='sum(backend_type_grpc_code_kubernetes_service_storage_type:buildbarn_blobstore_blob_access_operations_duration_seconds_count:irate1m{backend_type=~"$%s_backend_type",kubernetes_service=~"$kubernetes_service",storage_type="%s"}) by (grpc_code)' % [storageType, storageType],
            legendFormat='{{grpc_code}}',
          ),
        ],
      ),
    ),
  ] + [
    show_row(
      title=operation + '() duration',
      create_graph=function(title, storageType, width) simpledash.heatmap(
        title=title,
        width=width,
        unit=simpledash.unitDurationSeconds,
        targets=[
          simpledash.heatmapTarget(
            expr='sum(backend_type_kubernetes_service_le_operation_storage_type:buildbarn_blobstore_blob_access_operations_duration_seconds_bucket:irate1m{backend_type=~"$%s_backend_type",kubernetes_service=~"$kubernetes_service",operation="%s",storage_type="%s"}) by (le)' % [storageType, operation, storageType],
          ),
        ],
      ),
    )
    for operation in ['Get', 'Put', 'FindMissing']
  ] + [
    show_row(
      title=operation + '() object size',
      create_graph=function(title, storageType, width) simpledash.heatmap(
        title=title,
        width=width,
        unit=simpledash.unitBytes,
        targets=[
          simpledash.heatmapTarget(
            expr='sum(backend_type_kubernetes_service_le_operation_storage_type:buildbarn_blobstore_blob_access_operations_blob_size_bytes_bucket:irate1m{backend_type=~"$%s_backend_type",kubernetes_service=~"$kubernetes_service",operation="%s",storage_type="%s"}) by (le)' % [storageType, operation, storageType],
          ),
        ],
      ),
    )
    for operation in ['Get', 'Put']
  ] + [
    show_row(
      title='FindMissing() batch size',
      create_graph=function(title, storageType, width) simpledash.heatmap(
        title=title,
        width=width,
        unit=simpledash.unitNone,
        targets=[
          simpledash.heatmapTarget(
            expr='sum(backend_type_kubernetes_service_le_storage_type:buildbarn_blobstore_blob_access_operations_find_missing_batch_size_bucket:irate1m{backend_type=~"$%s_backend_type",kubernetes_service=~"$kubernetes_service",storage_type="%s"}) by (le)' % [storageType, storageType],
          ),
        ],
      ),
    ),
  ],
)
