local grafana = import 'grafonnet/grafana.libsonnet';

// SimpleDash: a set of wrapper around Grafonnet to declare dashboards
// using a very strict subset of features supported by Grafana.

local strContains(pat, str) =
  std.length(std.findSubstr(pat, str)) > 0;

local notEmpty(val) = val != null && std.length(val) > 0;

local slugify(text) = std.asciiLower(std.strReplace(text, ' ', '-'));

// Fill in the x and y coordinates of all panels.
local setPanelPositions(rows) = (
  local s = std.foldl(
    function(s, p)
      local end = s.x + p.gridPos.w;
      assert end <= 24 : 'Graph exceeds remaining width of dashboard row';
      s {
        x: if end == 24 then 0 else end,
        y+: if end == 24 then 1 else 0,
        panels+: [p { gridPos+: { x: s.x, y: s.y } }],
      },
    std.flattenArrays(rows),
    { x: 0, y: 0, panels: [] },
  );
  assert s.x == 0 : 'Last dashboard row still leaves space at the end';
  s.panels
);

local aggregationPeriodTemplate(aggregationPeriods) = (
  if notEmpty(aggregationPeriods) then [grafana.template.custom(
    name='aggregation_period',
    query=std.join(',', aggregationPeriods),
    current=aggregationPeriods[0],
    label='Aggregation Period',
  )] else []
);

// Set target graph interval if metric parameterized with aggregation period.
local setAggregationPeriod(panels, aggregationPeriods) = (
  std.map(
    function(panel) (
      panel + if notEmpty(aggregationPeriods) && std.objectHas(panel, 'targets') then {
        targets: std.map(
          function(target)
            target + if strContains('aggregation_period', target.expr) then { interval: '$aggregation_period' }
            else {},
          panel.targets
        ),
      } else {}
    ),
    panels
  )
);

{
  // Dashboard creation.
  dashboard(title, templates, rows, aggregationPeriods):: std.foldl(
    function(d, t) d.addTemplate(t),
    templates + aggregationPeriodTemplate(aggregationPeriods),
    grafana.dashboard.new(
      title=title,
      uid=slugify(title),
      schemaVersion=16,
      time_from='now-3h',
      refresh='10s',
      timezone='utc',
    ).addPanels(
      setAggregationPeriod(
        setPanelPositions(rows), aggregationPeriods
      )
    ),
  ),

  // Units for the graph Y axis.
  unitNone: { format: 'short', decimals: 0 },
  unitBytes: { format: 'bytes', decimals: 0 },
  unitBytesPerSecond: { format: 'Bps', decimals: 0 },
  unitDurationSeconds: { format: 's', decimals: 0 },
  unitDollars: { format: 'currencyUSD', decimals: 0 },
  unitOperationsPerSecond: { format: 'ops', decimals: 0 },
  unitPacketsPerSecond: { format: 'pps', decimals: 0 },
  unitPercent: { format: 'percentunit', decimals: 2 },
  unitReadsPerSecond: { format: 'rps', decimals: 0 },
  unitSeconds: { format: 'dtdurations', decimals: 0 },
  unitWritesPerSecond: { format: 'wps', decimals: 0 },

  // Whether the graph should be stacked, and when enabled, whether it
  // should be made to fill the graph as a percentage.
  stackingDisabled: {
    fill: 0,
    logBase1Y: null,
    min: null,
    max: null,
    stack: false,
  },
  stackingDisabledLogarithmic: self.stackingDisabled { logBase1Y: 10 },
  stackingEnabled: {
    fill: 7,
    logBase1Y: null,
    min: 0,
    max: null,
    stack: true,
  },
  stackingEnabledFill: self.stackingEnabled { max: 100 },

  // Graph creation.
  graph(title, width, stacking, targets, unit):: grafana.graphPanel.new(
    title=title,
    // When creating stacked graphs, force the bottom of the graph to be
    // zero. Also use a fill below the lines.
    fill=stacking.fill,
    logBase1Y=stacking.logBase1Y,
    min=stacking.min,
    max=stacking.max,
    sort='decreasing',
    stack=stacking.stack,
    format=unit.format,
    decimals=unit.decimals,
  ).addTargets(targets) {
    gridPos: {
      h: 8,
      w: width * 24,
    },
  } {
    percentage: stacking == $.stackingEnabledFill,
  },

  // Graph data source creation.
  graphTarget(expr, legendFormat):: grafana.prometheus.target(
    expr=expr,
    legendFormat=legendFormat,
  ),

  // Heatmap creation.
  heatmap(title, width, targets, unit):: {
    type: 'heatmap',
    title: title,
    color: {
      mode: 'spectrum',
      colorScheme: 'interpolateSpectral',
    },
    yAxis: {
      format: unit.format,
      decimals: unit.decimals,
    },
    legend: {
      show: true,
    },
    targets: targets,
    dataFormat: 'tsbuckets',
    gridPos: {
      h: 8,
      w: width * 24,
    },
    hideZeroBuckets: true,
  },

  // Heatmap data source creation.
  heatmapTarget(expr):: grafana.prometheus.target(
    expr=expr,
    format='heatmap',
    legendFormat='{{le}}',
    intervalFactor=10,
  ),

  // Dashboard row creation.
  row(title, panels):: [grafana.row.new(title=title) {
    gridPos: {
      h: 1,
      w: 24,
    },
  }] + panels,

  // Allow multiple values to be selected from a template variable
  // dropdown. Default to matching all values.
  selectMultiple: {
    multi: true,
    includeAll: true,
    current: null,
  },
  // Only allow a single value to be selected from a template variable
  // dropdown. The default selection value must be provided.
  selectSingleWithDefault(defaultValue): {
    assert std.isString(defaultValue),
    multi: false,
    includeAll: false,
    current: defaultValue,
  },

  // Dashboard template variable creation (i.e., a dropdown at the top
  // of the dashboard to filter results).
  template(name, query, label, selectionStyle):: grafana.template.new(
    name=name,
    datasource='Prometheus',
    query=query,
    label=label,
    refresh='time',
    multi=selectionStyle.multi,
    includeAll=selectionStyle.includeAll,
    current=selectionStyle.current,
    sort=1,
  ),

}
