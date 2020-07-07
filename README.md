# Helm from Jsonnet

This repository is a proof of concept for building Helm charts from Jsonnet. This is almost certainly not the way this should be done but it works at least.
The `values.yaml` is constructed using the top level `_config` hidden object that is common through Jsonnet libraries such as [cortex-jsonnet](https://github.com/grafana/cortex-jsonnet).
A dummy helm config is used in the Tanka/Jsonnet evaluation process to put the appropriate Go template strings in place for Helm templating.

See the Makefile to view the targets involved. To reconstruct all the files and view the resulting helm chart

```console
$ make -B
$ helm template . --generate-name
manifest_sorter.go:175: info: skipping unknown hook: "crd-install"
Error: create: failed to create: Secret "sh.helm.release.v1.chart-1594127945.v1" is invalid: data: Too long: must have at most 1048576 characters
```

## Issues

- YAML files output by `tk export` may themselves container Go templates (see Prometheus alert rules). Helm will error trying to parse these
- Currently cannot install rendered helm charts

The dummy helm config is constructed using the `template` function in `lib/helm.libsonnet`;

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
