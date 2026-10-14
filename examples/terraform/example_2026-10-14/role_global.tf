resource "elasticstack_kibana_security_role" "global_ro" {
  name = "global-ro"
  elasticsearch {
    indices {
      names = setunion(
        elasticstack_elasticsearch_index_template.kubernetes.index_patterns,
        elasticstack_elasticsearch_index_template.my_app.index_patterns,
      )
      privileges = ["read"]
    }
  }
  kibana {
    spaces = [
      elasticstack_kibana_space.global.id,
      elasticstack_kibana_space.kubernetes.id,
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
    feature {
      name       = "infrastructure"
      privileges = ["read"]
    }
  }
}
