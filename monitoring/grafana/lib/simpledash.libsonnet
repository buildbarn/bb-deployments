local grafonnet = import 'github.com/grafana/grafonnet/gen/grafonnet-v11.4.0/main.libsonnet';

// SimpleDash: a set of wrapper around Grafonnet to declare dashboards
// using a very strict subset of features supported by Grafana.

local dashboard = grafonnet.dashboard;
local variable = dashboard.variable;
local prometheus = grafonnet.query.prometheus;
local panel = grafonnet.panel;
local heatmap = panel.heatmap;
local timeSeries = panel.timeSeries;
local stat = panel.stat;
local util = grafonnet.util;

{
  // Dashboard creation.
  dashboard(title, templates, rows, config)::
    dashboard.new(title=title)
    + dashboard.withVariables(
      [
        variable.datasource.new(name='DS_PROMETHEUS', type='prometheus')
        + variable.datasource.generalOptions.withLabel(value='Datasource'),
        variable.query.new(name='cluster', query='label_values(cluster)')
        + (
          if config.enableMultiCluster
          then variable.query.generalOptions.showOnDashboard.withLabelAndValue()
          else variable.query.generalOptions.showOnDashboard.withNothing()
        ),
      ] + templates
    )
    + dashboard.withUid(util.string.slugify(title))
    + dashboard.time.withFrom(config.timerange)
    + dashboard.withRefresh(config.refresh)
    + dashboard.withTimezone(config.timezone)
    + dashboard.withPanels(
      util.panel.resolveCollapsedFlagOnRows(
        util.grid.wrapPanels(rows)
      )
    )
    + (
      if config.shareCrosshair then dashboard.graphTooltip.withSharedCrosshair()
      else {}
    ),

  // Units for the graph Y axis.
  unitNone: { format: 'short', decimals: 0 },
  unitBytes: { format: 'bytes', decimals: 0 },
  unitBytesPerSecond: { format: 'Bps', decimals: 0 },
  unitDollars: { format: 'currencyUSD', decimals: 0 },
  unitOperationsPerSecond: { format: 'ops', decimals: 0 },
  unitPacketsPerSecond: { format: 'pps', decimals: 0 },
  unitPercent: { format: 'percentunit', decimals: 2 },
  unitReadsPerSecond: { format: 'rps', decimals: 0 },
  unitSeconds: { format: 's', decimals: null },
  unitWritesPerSecond: { format: 'wps', decimals: 0 },

  // Whether the graph should be stacked, and when enabled, whether it
  // should be made to fill the graph as a percentage.
  stackingDisabled: {
    fillOpacity: 0,
    scaleDistribution: null,
    min: null,
    max: null,
    stack: false,
  },
  stackingDisabledLogarithmic: self.stackingDisabled {
    scaleDistribution: {
      log: 10,
      type: 'log',
    },
  },
  stackingEnabled: {
    fillOpacity: 70,
    scaleDistribution: null,
    min: 0,
    max: null,
    stack: {
      group: 'A',
      mode: 'normal',
    },
  },
  stackingEnabledFill: self.stackingEnabled {
    max: 1,
    stack+: { mode: 'percent' },
  },

  graph(title, width, stacking, targets, unit, interval=null)::
    timeSeries.new(
      title=title
    )
    + timeSeries.queryOptions.withTargets(targets)
    + timeSeries.queryOptions.withInterval(interval)
    + timeSeries.standardOptions.withUnit(unit.format)
    + timeSeries.standardOptions.withDecimals(unit.decimals)
    + timeSeries.panelOptions.withGridPos(h=8, w=width * 24)
    + timeSeries.fieldConfig.defaults.custom.withStacking(stacking.stack)
    + timeSeries.fieldConfig.defaults.custom.withScaleDistribution(stacking.scaleDistribution)
    + timeSeries.fieldConfig.defaults.custom.withSpanNulls(300000)  // Span nulls if gap is 5 minutes or lower
    + timeSeries.fieldConfig.defaults.custom.withFillOpacity(stacking.fillOpacity)
    + timeSeries.standardOptions.withMin(stacking.min)
    + timeSeries.standardOptions.withMax(stacking.max)
    + timeSeries.options.tooltip.withSort('desc')
    + timeSeries.options.tooltip.withMode('multi'),

  graphTarget(expr, legendFormat)::
    prometheus.new(
      expr=expr,
      datasource='${DS_PROMETHEUS}',
    )
    + prometheus.withLegendFormat(legendFormat)
    + prometheus.withFormat('time_series'),

  heatmap(title, width, targets, unit, interval=null)::
    heatmap.new(title)
    + heatmap.panelOptions.withGridPos(h=8, w=width * 24)
    + heatmap.queryOptions.withTargets(targets)
    + heatmap.queryOptions.withInterval(interval)
    + heatmap.options.color.withScheme('Spectral')
    + heatmap.options.color.withMode('scheme')
    + heatmap.options.yAxis.withUnit(unit.format)
    + heatmap.options.yAxis.withDecimals(unit.decimals)
    + heatmap.options.withTooltip({
      mode: 'single',
      hideZeros: false,
      sort: 'none',
    })
    + heatmap.options.legend.withShow(),

  heatmapTarget(expr)::
    prometheus.new(
      expr=expr,
      datasource='${DS_PROMETHEUS}',
    )
    + prometheus.withLegendFormat('{{le}}')
    + prometheus.withFormat('heatmap')
    + prometheus.withIntervalFactor(10),

  row(title, panels)::
    panel.row.new(title=title)
    + panel.row.withPanels(panels),

  selectMultiple:
    variable.query.selectionOptions.withMulti()
    + variable.query.selectionOptions.withIncludeAll()
    + variable.query.generalOptions.withCurrent(null),

  selectSingleWithDefault(defaultValue=null):
    {
      assert std.isString(defaultValue),
    }
    + variable.query.generalOptions.withCurrent(defaultValue),

  template(name, query, label, selectionStyle, regex='')::
    variable.query.new(
      name=name,
      query=query
    )
    + variable.query.generalOptions.withLabel(label)
    + selectionStyle
    + variable.query.withRegex(regex)
    + variable.query.withDatasource(type='prometheus', uid='${DS_PROMETHEUS}'),
}
