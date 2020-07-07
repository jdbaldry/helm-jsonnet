local cortex = import 'cortex/cortex.libsonnet';
local config = import './config.libsonnet';
local helm = import 'helm.libsonnet';

cortex {
  namespace:: 'removed',
  _config+:: helm.template(config),
}
