local helm = import 'helm.libsonnet';

local maintainers = [
  helm.maintainer.new('Jack Baldry')
  + helm.maintainer.withEmail('jack.baldry@grafana.com'),
];

std.manifestYamlDoc(
  helm.chart.new('v2', 'prometheus-ksonnet', '0.0.1')
  + helm.chart.withDescription('A set of extensible configs for running Prometheus on Kubernetes.')
  + helm.chart.withMaintainers(maintainers)
  + helm.chart.withIcon('https://prometheus.io/assets/prometheus_logo_grey.svg')
)
