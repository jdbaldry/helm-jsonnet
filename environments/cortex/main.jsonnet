local config = import './config.libsonnet';
local cortex = import 'cortex/cortex.libsonnet';
local helm = import 'helm.libsonnet';

cortex {
  _config+::
    if std.extVar('helm') then helm.template(config)
    else config,
}
