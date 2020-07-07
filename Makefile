.ONESHELL:
.DELETE_ON_ERROR:
SHELL       := bash
SHELLFLAGS  := -euf -o pipefail
MAKEFLAGS   += --warn-undefined-variables
MAKEFLAGS   += --no-builtin-rule

HELM_FILES  := templates/ Chart.yaml values.yaml
ENVIRONMENT := environments/cortex
TK_TARGETS  := '.*'

all: $(HELM_FILES) .lint

templates/: $(wildcard $(ENVIRONMENT)/*) lib/helm.libsonnet
	rm -fv templates/* >/dev/null
	tk export $(ENVIRONMENT) -t $(TK_TARGETS) $@

Chart.yaml: $(ENVIRONMENT)/Chart.jsonnet
	jsonnet -S -J lib -J vendor $< > $@

values.yaml: $(ENVIRONMENT)/values.jsonnet $(ENVIRONMENT)/config.libsonnet
	jsonnet -S -J lib -J vendor $< > $@

.lint: $(HELM_FILES)
	helm lint
	touch .lint
