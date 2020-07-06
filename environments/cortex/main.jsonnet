local cortex = import 'cortex/cortex.libsonnet';
local config = import './config.libsonnet';
local helm = import 'helm.libsonnet';

cortex {
  _config+:: helm.template(config),
}
