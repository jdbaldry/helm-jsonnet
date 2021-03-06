{
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
}
