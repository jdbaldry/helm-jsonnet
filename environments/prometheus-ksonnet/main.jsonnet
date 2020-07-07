local config = import './config.libsonnet';
local helm = import 'helm.libsonnet';
local prometheus_ksonnet = import 'prometheus-ksonnet/prometheus-ksonnet.libsonnet';

prometheus_ksonnet {
  namespace:: 'removed',
  _config+:: helm.template(config),
}
