resource "elasticstack_kibana_security_role" "traefik-read" {
  name = "traefik-read"
  elasticsearch {
    indices {
      names      = ["xxx3-traefik-traefik-*"]
      privileges = ["read"]
    }
  }
  kibana {
    spaces = ["traefik"]
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

resource "elasticstack_kibana_security_role" "traefik-rw" {
  name = "traefik-rw"
  elasticsearch {
    indices {
      names      = ["xxx3-traefik-traefik-*"]
      privileges = ["read", "write"]
    }
  }
  kibana {
    spaces = ["traefik"]
    feature {
      name       = "dashboard"
      privileges = ["all"]
    }
    feature {
      name       = "discover"
      privileges = ["all"]
    }
  }
}

resource "elasticstack_kibana_security_role" "tf" {
  name = "tf"
  elasticsearch {
    indices {
      names      = ["xxx3-traefik-traefik-*"]
      privileges = ["read"]
    }
  }
  kibana {
    spaces = [
      elasticstack_kibana_space.tf.space_id,
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
