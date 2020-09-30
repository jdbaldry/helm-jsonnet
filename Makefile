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
	tk show --dangerous-allow-redirect --extVar helm=template $(ENVIRONMENT) -t $(TK_TARGETS) > .manifests.yaml
	perl -0777 -pi -e 's/\((.*)\n\s+(.*)\)/(\1 \2)/g' .manifests.yaml
	perl -0777 -pi -e 's/␇/{/g' .manifests.yaml
	perl -0777 -pi -e 's/⍾/}/g' .manifests.yaml
	csplit --elide-empty-files -f $(@D)/manifest- -b '%02d.yaml' .manifests.yaml '/---/' '{*}'
	touch $@

%/Chart.yaml: $(ENVIRONMENT)/Chart.jsonnet
	jsonnet -S -J lib -J vendor $< > $@

%/values.yaml: $(ENVIRONMENT)/main.jsonnet
	jsonnet -V helm=values -S -J lib -J vendor $< > $@

%/.lint: $(HELM_FILES)
	cd $(@D)
	helm lint
	touch .lint
