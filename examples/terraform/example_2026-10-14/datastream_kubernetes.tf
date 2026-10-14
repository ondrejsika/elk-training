resource "elasticstack_elasticsearch_index_template" "kubernetes" {
  name           = "logs-kubernetes"
  index_patterns = ["logs-kubernetes*"]
  data_stream {}
  template {
    settings = jsonencode({
      "lifecycle.name" = elasticstack_elasticsearch_index_lifecycle.max_10_docs.name
    })
  }
}

resource "elasticstack_elasticsearch_data_stream" "kubernetes" {
  name = elasticstack_elasticsearch_index_template.kubernetes.name
}
