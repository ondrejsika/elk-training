terraform {
  required_providers {
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "0.16.5"
    }
  }
}

variable "elasticstack_elasticsearch_endpoint" {
  default = "https://es.k8s.sikademo.com"
}
variable "elasticstack_elasticsearch_password" {
  default = "elastic"
}

provider "elasticstack" {
  elasticsearch {
    endpoints = [var.elasticstack_elasticsearch_endpoint]
    username  = "elastic"
    password  = var.elasticstack_elasticsearch_password
  }
}

resource "elasticstack_elasticsearch_security_role" "read" {
  name = "read"

  indices {
    names      = [
      "filebeat-*",
      "logs-*",
    ]
    privileges = ["read"]
  }

  applications {
    application = "*"
    privileges  = ["read"]
    resources   = ["*"]
  }
}

resource "elasticstack_elasticsearch_security_user" "foo" {
  username = "foo"
  password = "asdfasdf"
  roles = [
    elasticstack_elasticsearch_security_role.read.name,
  ]
  metadata = jsonencode({
    "foo" = "bar"
  })
}

resource "elasticstack_elasticsearch_security_user" "bar" {
  username = "bar"
  password = "asdfasdf"
  roles = [
    elasticstack_elasticsearch_security_role.read.name,
  ]
  metadata = jsonencode({
    "foo" = "bar"
  })
}
