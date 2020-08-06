{
  // hasGoTemplate returns true if it believes a string contains a Go template.
  hasGoTemplate(s)::
    local braces = std.filter(function(e) e == '{' || e == '}', std.stringChars(s));
    std.count(braces, '{') >= 2 && std.count(braces, '{') == std.count(braces, '}'),

  // escape escapes all strings that contain Go templates as these will cause errors when Helm tries to render a template.
  // https://github.com/helm/helm/issues/2798.
  // Unfortunately, any backticks (`) will terminate the escape string so now we need to replace them with something else.
  // Presently this function just replaces them with single quotes (') instead and hopes for the best.
  escape(v)::
    local aux(v, path) =
      if std.isObject(v) then
        std.mapWithKey(function(k, v) aux(v, path + k), v)
      else if std.isArray(v) then
        std.mapWithIndex(function(i, e) aux(e, path + i), v)
      else if std.isString(v) && self.hasGoTemplate(v) then
        '{{`%s`}}' % std.strReplace(v, '`', "'")
      else
        v;
    aux(v, path=[]),

  // template substitutes all primitive values with Go template that references the path to that value.
  // This facilitates a mapping between the Kausal pattern of an _config hidden object that is used to configure Jsonnet libraries
  // and the values.yaml that is used in Helm templating.
  template(v)::
    local aux(v, path) =
      if std.isObject(v) then
        std.mapWithKey(function(k, v) aux(v, path + '.%s' % k), v)
      else if std.isArray(v) then
        std.mapWithIndex(function(i, e) aux(e, '(index %s %d)' % [path, i]), v)
      else
        '{{%s}}' % path;
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
