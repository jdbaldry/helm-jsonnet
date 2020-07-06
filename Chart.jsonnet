local helm = import 'helm.libsonnet';

local maintainers = [
  helm.maintainer.new('Jack Baldry')
  + helm.maintainer.withEmail('jack.baldry@grafana.com'),
];

std.manifestYamlDoc(
  helm.chart.new('v2', 'cortex', '0.0.1')
  + helm.chart.withDescription('Horizontally scalable, highly available, multi-tenant, long term Prometheus.')
  + helm.chart.withMaintainers(maintainers)
  + helm.chart.withIcon('https://cortexmetrics.io/images/cortex-horizontal.svg')
)
