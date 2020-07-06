.ONESHELL:
.DELETE_ON_ERROR:
SHELL       := bash
SHELLFLAGS  := -euf -o pipefail
MAKEFLAGS   += --warn-undefined-variables
MAKEFLAGS   += --no-builtin-rule

HELM_FILES := templates/ Chart.yaml values.yaml

all: $(HELM_FILES) .lint

templates/: environments/cortex/main.jsonnet
	rm -fv templates/*
	tk export environments/cortex $@

Chart.yaml: Chart.jsonnet
	jsonnet -S -J lib -J vendor $< > $@

values.yaml: values.jsonnet environments/cortex/config.libsonnet
	jsonnet -S -J lib -J vendor $< > $@

.lint: $(HELM_FILES)
	helm lint
	touch .lint
