local helm = import 'helm.libsonnet';
local cortex = (import 'cortex/cortex.libsonnet') {
  _config+:: {
    // Unfortunately I cannot catch Jsonnet errors so we have to specify a value for everything.
    aws_region: null,
    cassandra_addresses: null,
    ruler_gcs_bucket_name: null,
    s3_bucket_name: null,
    storage_tsdb_bucket_name: null,
    test_exporter_start_time: null,
    test_exporter_user_id: null,

    cluster: 'test',
    external_url: 'localhost:8080',

    namespace: 'default',
    schema: [{
      from: '2019-11-15',
      store: 'bigtable-hashed',
      object_store: 'gcs',
      schema: 'v10',
      index: {
        prefix: 'dev_index_',
        period: '168h',
      },
      chunks: {
        prefix: 'dev_chunks_',
        period: '168h',
      },
    }],
    storage_backend: 'gcp',
    bigtable_instance: 'example-instance-prod',
    bigtable_project: 'example-project1-cortex',
    ruler_client_type: 'gcs',
  },
};

if std.extVar('helm') == 'template' then
  helm.template(cortex)
else if std.extVar('helm') == 'values' then
  std.manifestYamlDoc(cortex._config)
else
  cortex
