# Buildbarn cache with traces and metrics collection

This deployment is Datadog-centric, but it ought to be fairly straightforward to swap out the Datadog-specific bits for any other upstream that supports Opentelemetry.

## Deployment Attributes

1. sharded local storage, with each pod having 250GB for CAS, 250GB for AC, and 5GB for persistence
2. traces being sent to Datadog via the opentelemetry collector in daemon mode. The trace sampler is set to "always" because the preferred approach is to send all traces to Datadog, and then sample down based on your cost needs on the datadog side. This is because analytics data comes from all ingested spans, not just the retained ones.
3. scrape prometheus metrics to Datadog into the metrics namespace "buildbarn". This includes the metrics for the Opentelemetry Collector, so you can have some visibility into ingestion rate, errors, etc.

## Further reading

- Datadog prometheus scraping configuration: https://docs.datadoghq.com/agent/kubernetes/prometheus/
- Datadog span retention: https://docs.datadoghq.com/tracing/trace_retention_and_ingestion

## Usage Notes

1. Make sure to generate hashInitialization values for common.yaml
2. Change serviceDnsName to reflect the actual DNS names assigned to services in your deployment
3. Set the number of storage replicas to suit your storage and throughput needs.
4. Configure the volumeClaimTemplates to suit your cluster's implementation. We're on AWS using basic gp2 EBS volumes and a large disk cache with no I/O issues on the volumes so far.

Changing the number of replicas for the storage nodes will cause a redeployment of all frontend nodes, because the config will change. It will also rearrange the keyspace and cause the bulk of your cache to go cold.

## Requirements:

1. Datadog agent already deployed in the kubernetes cluster: https://docs.datadoghq.com/agent/kubernetes/?tab=helm#installation