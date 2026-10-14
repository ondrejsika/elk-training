resource "elasticstack_kibana_security_role" "my_app_ro" {
  name = "my-app-ro"
  elasticsearch {
    indices {
      names      = elasticstack_elasticsearch_index_template.my_app.index_patterns
      privileges = ["read"]
    }
  }
  kibana {
    spaces = [
      elasticstack_kibana_space.my_app.id,
    ]
    feature {
      name       = "dashboard"
      privileges = ["read"]
    }
    feature {
      name       = "discover"
      privileges = ["read"]
    }
  }
}

resource "elasticstack_kibana_security_role" "my_app_wo" {
  name = "my-app-wo"
  elasticsearch {
    cluster = ["monitor", "manage_index_templates"]
    indices {
      names      = elasticstack_elasticsearch_index_template.my_app.index_patterns
      privileges = ["create_doc", "create", "write", "view_index_metadata"]
    }
  }
}
