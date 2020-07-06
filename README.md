# Helm from Jsonnet

This repository is a proof of concept for building Helm charts from Jsonnet. This is almost certainly not the way this should be done but it works at least.
The `values.yaml` is constructed using the top level `_config` hidden object that is common through Jsonnet libraries such as [cortex-jsonnet](https://github.com/grafana/cortex-jsonnet).
A dummy helm config is used in the Tanka/Jsonnet evaluation process to put the appropriate Go template strings in place for Helm templating.

See the Makefile to view the targets involved. To reconstruct all the files and view the resulting helm chart

```
$ make -B
$ helm template .
```

The dummy helm config is constructed using the `template` function in `lib/helm.libsonnet`;

## Dependencies

For nixos:

```
$ nix-shell
```

or if you have Lorri and direnv:

```
$ direnv allow
```

Otherwise, you need [tanka](https://github.com/grafana/tanka), [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler), [helm](https://github.com/helm/helm), and [jsonnet](https://github.com/google/go-jsonnet)