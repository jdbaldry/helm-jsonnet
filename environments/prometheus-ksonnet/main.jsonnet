local config = import './config.libsonnet';
local helm = import 'helm.libsonnet';
local prometheus_ksonnet = helm.escape((import 'prometheus-ksonnet/prometheus-ksonnet.libsonnet') + { _config+:: config });

prometheus_ksonnet {
  namespace:: 'removed',
  _config+:: helm.template(config),
}
