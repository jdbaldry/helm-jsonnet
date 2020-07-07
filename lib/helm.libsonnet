{
  template(v)::
    local aux(v, path) =
      if (std.isBoolean(v) || std.isString(v) || std.isNumber(v)) then
        '{{%s}}' % path
      else if std.isArray(v) then
        std.mapWithIndex(function(i, e) aux(e, '(index %s %d)' % [path, i]), v)
      else
        std.mapWithKey(function(k, v) aux(v, path + '.%s' % k), v);
    aux(v, path='.Values'),

  // https://helm.sh/docs/topics/charts/
  chart:: {
    new(apiVersion, name, version):: {
      apiVersion: apiVersion,
      name: name,
      // TODO: assert version is 'a SemVer 2 version'.
      version: version,
    },
    withKubeVersion(kubeVersion):: {
      // TODO: assert kubeVersion is 'a SemVer range'.
      kubeVersion: kubeVersion,
    },
    withDescription(description):: {
      description: description,
    },
    withType(type):: {
      type: type,
    },
    withKeywords(keywords):: {
      assert std.isArray(keywords),
      keywords: keywords,
    },
    withKeywordsMixin(keywords):: {
      assert std.isArray(keywords),
      keywords+: keywords,
    },
    withHome(home):: {
      home: home,
    },
    withSources(sources):: {
      assert std.isArray(sources),
      sources: sources,
    },
    withSourcesMixin(sources):: {
      assert std.isArray(sources),
      sources+: sources,
    },
    withDependencies(dependencies):: {
      assert std.isArray(dependencies),
      dependencies: dependencies,
    },
    withDependenciesMixin(dependencies):: {
      assert std.isArray(dependencies),
      dependencies+: dependencies,
    },
    withMaintainers(maintainers):: {
      assert std.isArray(maintainers),
      maintainers: maintainers,
    },
    withMaintainersMixin(maintainers):: {
      assert std.isArray(maintainers),
      maintainers+: maintainers,
    },
    withIcon(icon):: {
      icon: icon,
    },
    withAppVersion(appVersion):: {
      appVersion: appVersion,
    },
    withDeprecated(deprecated):: {
      assert std.isBool(deprecated),
      deprecated: deprecated,
    },
    withAnnotations(annotations):: {
      assert std.isArray(annotations),
      annotations: annotations,
    },
    withAnnotationsMixin(annotations):: {
      assert std.isArray(annotations),
      annotations+: annotations,
    },
  },

  dependency:: {
    new(name, version, repository):: {
      name: name,
      version: version,
      repository: repository,
    },
    withCondition(condition):: {
      condition: condition,
    },
    withTags(tags):: {
      assert std.isArray(tags),
      tags: tags,
    },
    withTagsMixin(tags):: {
      assert std.isArray(tags),
      tags+: tags,
    },
    withEnabled(enabled):: {
      assert std.isBool(enabled),
      enabled: enabled,
    },
    withImportValues(importValues):: {
      'import-values': importValues,
    },
    withImportValuesMixin(importValues):: {
      'import-values'+: importValues,
    },
    withAlias(alias):: {
      alias: alias,
    },
  },

  maintainer:: {
    new(name):: {
      name: name,
    },
    withEmail(email):: {
      email: email,
    },
    withUrl(url):: {
      url: url,
    },
  },
}
