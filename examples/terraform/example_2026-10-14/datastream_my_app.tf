resource "elasticstack_elasticsearch_index_template" "my_app" {
  name           = "logs-my-app"
  index_patterns = ["logs-my-app*"]
  data_stream {}
  template {
    settings = jsonencode({
      "number_of_replicas" = 2
      "lifecycle.name"     = elasticstack_elasticsearch_index_lifecycle.max_10_docs.name
    })
  }
}

resource "elasticstack_elasticsearch_data_stream" "my_app" {
  name = elasticstack_elasticsearch_index_template.my_app.name
}
