{
  _config+:: {
    // Default timezone.
    timezone: 'utc',
    // Default refresh period.
    refresh: '10s',
    // Enables a multicluster setup, meaning the dashboards are filterable
    // by cluster.
    enableMultiCluster: false,
    // Default cluster label for filtering by cluster,
    // i.e. `<query>{<clusterLabel>="$cluster"}`.
    clusterLabel: 'cluster',
    // Default time range.
    timerange: 'now-3h',
    // Share cursor by default.
    shareCrosshair: true,
  },
}
