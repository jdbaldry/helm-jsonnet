.ONESHELL:
.DELETE_ON_ERROR:
SHELL       := bash
SHELLFLAGS  := -euf -o pipefail
MAKEFLAGS   += --warn-undefined-variables
MAKEFLAGS   += --no-builtin-rule

ENVIRONMENT := environments/cortex
CHARTS_DIR  := $(subst environments, charts, $(ENVIRONMENT))
HELM_FILES  := $(patsubst %, $(CHARTS_DIR)/%, templates/.uptodate Chart.yaml values.yaml)
TK_TARGETS  := '.*'

all: $(HELM_FILES) $(CHARTS_DIR)/.lint

.PRECIOUS: %/templates
%/templates:
	mkdir -p $@

%/templates/.uptodate: $(wildcard $(ENVIRONMENT)/*) lib/helm.libsonnet | %/templates
	rm -f -- $(@D)/* $(@D)/.uptodate
	tk export -e helm=true $(ENVIRONMENT) -t $(TK_TARGETS) $(@D)
	touch $@

%/Chart.yaml: $(ENVIRONMENT)/Chart.jsonnet
	jsonnet -S -J lib -J vendor $< > $@

%/values.yaml: $(ENVIRONMENT)/values.jsonnet $(ENVIRONMENT)/config.libsonnet
	jsonnet -S -J lib -J vendor $< > $@

%/.lint: $(HELM_FILES)
	cd $(@D)
	helm lint
	touch .lint
