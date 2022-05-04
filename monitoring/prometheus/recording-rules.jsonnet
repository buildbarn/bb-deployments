{
  groups: [
    {
      name: 'recording_rules',
      rules: [
        // Take the existing blob size and batch size metrics and
        // turn them into a single aggregated metric per operation.
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_blob_size_bytes_count{job="kubernetes-service-endpoints"}[1m])) by (backend_type, kubernetes_service, operation, storage_type)',
          record: 'backend_type_kubernetes_service_operation_storage_type:buildbarn_blobstore_blob_access_operations_started:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_find_missing_batch_size_count{job="kubernetes-service-endpoints"}[1m])) by (backend_type, kubernetes_service, storage_type)',
          labels: {
            operation: 'FindMissing',
          },
          record: 'backend_type_kubernetes_service_operation_storage_type:buildbarn_blobstore_blob_access_operations_started:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_duration_seconds_bucket{job="kubernetes-service-endpoints"}[1m])) by (backend_type, kubernetes_service, le, operation, storage_type)',
          record: 'backend_type_kubernetes_service_le_operation_storage_type:buildbarn_blobstore_blob_access_operations_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_duration_seconds_count{job="kubernetes-service-endpoints"}[1m])) by (backend_type, grpc_code, kubernetes_service, storage_type)',
          record: 'backend_type_grpc_code_kubernetes_service_storage_type:buildbarn_blobstore_blob_access_operations_duration_seconds_count:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_find_missing_batch_size_bucket{job="kubernetes-service-endpoints"}[1m])) by (backend_type, kubernetes_service, le, storage_type)',
          record: 'backend_type_kubernetes_service_le_storage_type:buildbarn_blobstore_blob_access_operations_find_missing_batch_size_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_blob_size_bytes_bucket{job="kubernetes-service-endpoints"}[1m])) by (backend_type, kubernetes_service, le, operation, storage_type)',
          record: 'backend_type_kubernetes_service_le_operation_storage_type:buildbarn_blobstore_blob_access_operations_blob_size_bytes_bucket:irate1m',
        },

        // Statistics on retention of centralized storage.
        {
          expr: 'min(time() - buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds{job="kubernetes-service-endpoints",kubernetes_service="bb-storage"}) by (kubernetes_replica, kubernetes_shard, storage_type)',
          record: 'kubernetes_replica_kubernetes_shard_storage_type:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds',
        },
        {
          expr: 'min(kubernetes_replica_kubernetes_shard_storage_type:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds) by (kubernetes_replica, storage_type)',
          record: 'kubernetes_replica_storage_type:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds:min',
        },
        {
          expr: 'max(kubernetes_replica_kubernetes_shard_storage_type:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds) by (kubernetes_shard, storage_type)',
          record: 'kubernetes_shard_storage_type:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds:max',
        },
        {
          expr: 'min(kubernetes_replica_kubernetes_shard_storage_type:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds) by (kubernetes_shard, storage_type)',
          record: 'kubernetes_shard_storage_type:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds:min',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_get_attempts_count{job="kubernetes-service-endpoints",kubernetes_service="bb-storage"}[1m])) by (storage_type, outcome)',
          record: 'outcome_storage_type:buildbarn_blobstore_hashing_key_location_map_get_attempts_count:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_get_too_many_attempts_total{job="kubernetes-service-endpoints",kubernetes_service="bb-storage"}[1m])) by (storage_type)',
          record: 'storage_type:buildbarn_blobstore_hashing_key_location_map_get_too_many_attempts:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_get_attempts_bucket{job="kubernetes-service-endpoints",kubernetes_service="bb-storage"}[1m])) by (le, storage_type)',
          record: 'le_storage_type:buildbarn_blobstore_hashing_key_location_map_get_attempts_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_put_ignored_invalid_total{job="kubernetes-service-endpoints",kubernetes_service="bb-storage"}[1m])) by (storage_type)',
          record: 'storage_type:buildbarn_blobstore_hashing_key_location_map_put_ignored_invalid:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_put_iterations_count{job="kubernetes-service-endpoints",kubernetes_service="bb-storage"}[1m])) by (outcome, storage_type)',
          record: 'outcome_storage_type:buildbarn_blobstore_hashing_key_location_map_put_iterations_count:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_put_too_many_iterations_total{job="kubernetes-service-endpoints",kubernetes_service="bb-storage"}[1m])) by (storage_type)',
          record: 'storage_type:buildbarn_blobstore_hashing_key_location_map_put_too_many_iterations:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_put_iterations_bucket{job="kubernetes-service-endpoints",kubernetes_service="bb-storage"}[1m])) by (le, storage_type)',
          record: 'le_storage_type:buildbarn_blobstore_hashing_key_location_map_put_iterations_bucket:irate1m',
        },

        // Rate at which tasks are processed by the scheduler.
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_scheduled_total{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}[1m])) by (instance_name_prefix, platform, size_class)',
          record: 'instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_queued:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_count{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}[1m])) by (instance_name_prefix, platform, size_class)',
          record: 'instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_executing:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_count{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}[1m])) by (grpc_code, instance_name_prefix, platform, result, size_class)',
          record: 'grpc_code_instance_name_prefix_platform_result_size_class:buildbarn_builder_in_memory_build_queue_tasks_completed:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_completed_duration_seconds_count{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}[1m])) by (instance_name_prefix, platform, size_class)',
          record: 'instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_removed:irate1m',
        },

        // Subtract counters of consecutive scheduler stages to derive
        // how many tasks are in each of the stages.
        {
          expr: |||

            sum(buildbarn_builder_in_memory_build_queue_tasks_scheduled_total{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}) by (instance_name_prefix, platform, size_class)
            -
            sum(buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_count{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}) by (instance_name_prefix, platform, size_class)
          |||,
          record: 'instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_queued:sum',
        },
        {
          expr: |||

            sum(buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_count{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}) by (instance_name_prefix, platform, size_class)
            -
            sum(buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_count{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}) by (instance_name_prefix, platform, size_class)
          |||,
          record: 'instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_executing:sum',
        },
        {
          expr: |||
            sum(buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_count{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}) by (instance_name_prefix, platform, size_class)
            -
            sum(buildbarn_builder_in_memory_build_queue_tasks_completed_duration_seconds_count{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}) by (instance_name_prefix, platform, size_class)
          |||,
          record: 'instance_name_prefix_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_completed:sum',
        },

        // Duration of how long tasks remain in scheduler stages.

        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_bucket{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}[1m])) by (instance_name_prefix, le, platform, size_class)',
          record: 'instance_name_prefix_le_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_bucket{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}[1m])) by (instance_name_prefix, le, platform, size_class)',
          record: 'instance_name_prefix_le_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_completed_duration_seconds_bucket{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}[1m])) by (instance_name_prefix, le, platform, size_class)',
          record: 'instance_name_prefix_le_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_completed_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_executing_retries_bucket{job="kubernetes-service-endpoints",kubernetes_service="bb-scheduler"}[1m])) by (instance_name_prefix, le, platform, size_class)',
          record: 'instance_name_prefix_le_platform_size_class:buildbarn_builder_in_memory_build_queue_tasks_executing_retries_bucket:irate1m',
        },

        // Recording rules used by the "BuildExecutor" dashboard.
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_duration_seconds_count{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service)',
          record: 'kubernetes_service:buildbarn_builder_build_executor_operations:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_duration_seconds_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le, stage)',
          record: 'kubernetes_service_le_stage:buildbarn_builder_build_executor_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_virtual_execution_duration_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_virtual_execution_duration_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_user_time_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_user_time_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_system_time_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_system_time_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_maximum_resident_set_size_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_maximum_resident_set_size_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_maximum_resident_set_size_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_maximum_resident_set_size_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_page_reclaims_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_page_reclaims_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_page_faults_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_page_faults_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_swaps_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_swaps_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_block_input_operations_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_block_input_operations_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_block_output_operations_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_block_output_operations_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_messages_sent_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_messages_sent_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_messages_received_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_messages_received_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_signals_received_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_signals_received_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_voluntary_context_switches_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_voluntary_context_switches_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_involuntary_context_switches_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_posix_involuntary_context_switches_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_files_created_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_file_pool_files_created_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_files_count_peak_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_file_pool_files_count_peak_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_files_size_bytes_peak_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le)',
          record: 'kubernetes_service_le:buildbarn_builder_build_executor_file_pool_files_size_bytes_peak_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_operations_count_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le, operation)',
          record: 'kubernetes_service_le_operation:buildbarn_builder_build_executor_file_pool_operations_count_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_operations_size_bytes_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le, operation)',
          record: 'kubernetes_service_le_operation:buildbarn_builder_build_executor_file_pool_operations_size_bytes_bucket:irate1m',
        },

        // Recording rules for the "Eviction sets" dashboard.
        {
          expr: 'sum(rate(buildbarn_eviction_set_operations_total{job="kubernetes-service-endpoints"}[1h])) by (kubernetes_service, name, operation)',
          record: 'kubernetes_service_name_operation:buildbarn_eviction_set_operations:rate1h',
        },

        // Recording rules used by the 'gRPC clients' dashboard.
        {
          expr: |||
            sum(
              grpc_client_started_total{job="kubernetes-service-endpoints"}
              -
              sum(grpc_client_handled_total{job="kubernetes-service-endpoints"}) without (grpc_code)
            ) by (grpc_method, grpc_service, kubernetes_service)
          |||,
          record: 'grpc_method_grpc_service_kubernetes_service:grpc_client_in_flight:sum',
        },
        {
          expr: 'sum(irate(grpc_client_handled_total{job="kubernetes-service-endpoints"}[1m])) by (grpc_code, grpc_method, grpc_service, kubernetes_service)',
          record: 'grpc_code_grpc_method_grpc_service_kubernetes_service:grpc_client_handled:irate1m',
        },
        {
          expr: 'sum(irate(grpc_client_msg_sent_total{job="kubernetes-service-endpoints"}[1m])) by (grpc_method, grpc_service, kubernetes_service)',
          record: 'grpc_method_grpc_service_kubernetes_service:grpc_client_msg_sent:irate1m',
        },
        {
          expr: 'sum(irate(grpc_client_msg_received_total{job="kubernetes-service-endpoints"}[1m])) by (grpc_method, grpc_service, kubernetes_service)',
          record: 'grpc_method_grpc_service_kubernetes_service:grpc_client_msg_received:irate1m',
        },
        {
          expr: 'sum(irate(grpc_client_handling_seconds_bucket{job="kubernetes-service-endpoints"}[1m])) by (grpc_method, grpc_service, kubernetes_service, le)',
          record: 'grpc_method_grpc_service_kubernetes_service_le:grpc_client_handling_seconds_bucket:irate1m',
        },

        // Recording rules used by the 'gRPC servers' dashboard.
        {
          expr: |||
            sum(
              grpc_server_started_total{job="kubernetes-service-endpoints"}
              -
              sum(grpc_server_handled_total{job="kubernetes-service-endpoints"}) without (grpc_code)
            ) by (grpc_method, grpc_service, kubernetes_service)
          |||,
          record: 'grpc_method_grpc_service_kubernetes_service:grpc_server_in_flight:sum',
        },
        {
          expr: 'sum(irate(grpc_server_handled_total{job="kubernetes-service-endpoints"}[1m])) by (grpc_method, grpc_service, kubernetes_service)',
          record: 'grpc_method_grpc_service_kubernetes_service:grpc_server_handled:irate1m',
        },
        {
          expr: 'sum(irate(grpc_server_handled_total{job="kubernetes-service-endpoints"}[1m])) by (grpc_code, grpc_method, grpc_service, kubernetes_service)',
          record: 'grpc_code_grpc_method_grpc_service_kubernetes_service:grpc_server_handled:irate1m',
        },
        {
          expr: 'sum(irate(grpc_server_msg_sent_total{job="kubernetes-service-endpoints"}[1m])) by (grpc_method, grpc_service, kubernetes_service)',
          record: 'grpc_method_grpc_service_kubernetes_service:grpc_server_msg_sent:irate1m',
        },
        {
          expr: 'sum(irate(grpc_server_msg_received_total{job="kubernetes-service-endpoints"}[1m])) by (grpc_method, grpc_service, kubernetes_service)',
          record: 'grpc_method_grpc_service_kubernetes_service:grpc_server_msg_received:irate1m',
        },
        {
          expr: 'sum(irate(grpc_server_handling_seconds_bucket{job="kubernetes-service-endpoints"}[1m])) by (grpc_method, grpc_service, kubernetes_service, le)',
          record: 'grpc_method_grpc_service_kubernetes_service_le:grpc_server_handling_seconds_bucket:irate1m',
        },

        // Recording rules used by the 'FUSE' dashboard.
        {
          expr: |||
            sum(
              irate(buildbarn_fuse_raw_file_system_callbacks_total{job="kubernetes-service-endpoints"}[1m])
              or
              irate(buildbarn_fuse_raw_file_system_operations_duration_seconds_count{job="kubernetes-service-endpoints"}[1m])
            ) by (status_code)
          |||,
          record: 'status_code:buildbarn_fuse_raw_file_system_callbacks_and_operations:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_fuse_raw_file_system_operations_duration_seconds_count{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, operation, status_code)',
          record: 'kubernetes_service_operation_status_code:buildbarn_fuse_raw_file_system_operations_duration_seconds_count:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_fuse_raw_file_system_operations_duration_seconds_bucket{job="kubernetes-service-endpoints"}[1m])) by (kubernetes_service, le, operation, status_code)',
          record: 'kubernetes_service_le_operation_status_code:buildbarn_fuse_raw_file_system_operations_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_fuse_raw_file_system_callbacks_total{job="kubernetes-service-endpoints"}[1m])) by (callback, kubernetes_service, status_code)',
          record: 'callback_kubernetes_service_status_code:buildbarn_fuse_raw_file_system_callbacks:irate1m',
        },
      ],
    },
  ],
}
