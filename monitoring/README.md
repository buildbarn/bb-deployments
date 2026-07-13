# Work In Progress: Prometheus recording rules and Grafana dashboards

This directory contains a set of Grafana dashboards for Buildbarn. In
order to render them efficiently, they rely on Prometheus recording
rules that are also provided.

All of the source files in this directory are written in Jsonnet.
Grafana dashboards make use of [Grafonnet](https://github.com/grafana/grafonnet).
Bazel build rules are provided that convert them to JSON. Building all
of the Grafana dashboards is as simple as running:

```
bazel build //monitoring/grafana:dashboards
```

An eventual goal would be to integrate these dashboards into the
Kubernetes manifests that are also stored in this repository. Maybe it
makes sense to inject the recording rules into Prometheus using the
[Prometheus operator](https://github.com/coreos/prometheus-operator)?
Contributions in this area are more than welcome!

## Dashboard default values

The file `config.libsonnet` includes a few configurable default
values for all dashboards. To override a default value for a single
dashboards, for example `timerange`:

```jsonnet
  'example-dashboard.jsonnet': simpledash.dashboard(
    ...
    config=$._config {
        timerange: 'now-6h',
    },
  ),
```
