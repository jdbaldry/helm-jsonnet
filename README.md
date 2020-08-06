# Helm from Jsonnet

This repository is a proof of concept for building Helm charts from Jsonnet. This is almost certainly not the way this should be done but it works at least.

The `values.yaml` is constructed using the top level `_config` hidden object that is common through Jsonnet libraries such as [cortex-jsonnet](https://github.com/grafana/cortex-jsonnet).

A dummy `_config` object is used in the Tanka/Jsonnet evaluation process to put the appropriate Go template strings in place for Helm templating. For more detail see the `environments/cortex/main.jsonnet` file.

See the Makefile to view the targets involved. To reconstruct all the files and view the resulting helm chart

```console
$ make -B
$ helm template helm/cortex --generate-name
```

The dummy helm config is constructed using the `template` function in `lib/helm.libsonnet`;

Helm uses Go templates which can cause issues when Jsonnet libraries have Go templates themselves like in the prometheus-ksonnet library. This is
an issue with helm (https://github.com/helm/helm/issues/2798).
To work around this, an `escape` function has been written that has Helm render raw strings.

```jsonnet
local config = import './config.libsonnet';
local helm = import 'helm.libsonnet';
local prometheus_ksonnet = helm.escape((import 'prometheus-ksonnet/prometheus-ksonnet.libsonnet') + { _config+:: config });

prometheus_ksonnet {
  namespace:: 'removed',
  _config+:: helm.template(config),
}
```

## Dependencies

For nixos:

```console
$ nix-shell
```

or if you have Lorri and direnv:

```console
$ direnv allow
```

Otherwise, you need [tanka](https://github.com/grafana/tanka), [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler), [helm](https://github.com/helm/helm), and [jsonnet](https://github.com/google/go-jsonnet)
