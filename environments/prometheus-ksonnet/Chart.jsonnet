local helm = import 'helm.libsonnet';

local maintainers = [
  helm.maintainer.new('Jack Baldry')
  + helm.maintainer.withEmail('jack.baldry@grafana.com'),
];

std.manifestYamlDoc(
  helm.chart.new('v2', 'prometheus-ksonnet', '0.0.1')
  + helm.chart.withDescription('A set of extensible configs for running Prometheus on Kubernetes.')
  + helm.chart.withMaintainers(maintainers)
  + helm.chart.withIcon('https://cortexmetrics.io/images/cortex-horizontal.svg')
  + helm.chart.withDependencies(
    [helm.dependency.new('etcd-operator', '0.10.3', 'https://kubernetes-charts.storage.googleapis.com/')]
  )
)
