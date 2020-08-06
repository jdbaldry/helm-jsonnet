local config = import './config.libsonnet';
local helm = import 'helm.libsonnet';
local prometheus_ksonnet = import 'prometheus-ksonnet/prometheus-ksonnet.libsonnet';

if std.extVar('helm') then
  helm.escape(prometheus_ksonnet { _config+:: config }) {
    _config+:: helm.template(config),
  }
else
  prometheus_ksonnet {
    _config+:: config,
  }
