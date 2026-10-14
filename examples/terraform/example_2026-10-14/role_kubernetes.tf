resource "elasticstack_kibana_security_role" "kubernetes_ro" {
  name = "kubernetes-ro"
  elasticsearch {
    indices {
      names      = elasticstack_elasticsearch_index_template.kubernetes.index_patterns
      privileges = ["read"]
    }
  }
  kibana {
    spaces = [
      elasticstack_kibana_space.kubernetes.id,
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

resource "elasticstack_kibana_security_role" "kubernetes_wo" {
  name = "kubernetes-wo"
  elasticsearch {
    indices {
      names      = elasticstack_elasticsearch_index_template.kubernetes.index_patterns
      privileges = ["write"]
    }
  }
}
