local helm = import 'helm.libsonnet';
local prometheus_ksonnet = (import 'prometheus-ksonnet/prometheus-ksonnet.libsonnet') {
  _config+:: {
    namespace: 'default',
    cluster_name: 'helm',
  },
};

if std.extVar('helm') == 'template' then
  helm.template(prometheus_ksonnet)
else if std.extVar('helm') == 'values' then
  std.manifestYamlDoc(prometheus_ksonnet._config)
else
  prometheus_ksonnet
