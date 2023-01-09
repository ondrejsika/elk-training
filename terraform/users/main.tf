terraform {
  required_providers {
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "0.5.0"
    }
  }
}

variable "elasticstack_elasticsearch_password" {}

provider "elasticstack" {
  elasticsearch {
    endpoints = ["https://es.k8s.sikademo.com"]
    username  = "elastic"
    password  = var.elasticstack_elasticsearch_password
  }
}

resource "elasticstack_elasticsearch_security_user" "foo" {
  username = "foo"
  password = "asdfasdf"
  roles = [
    "viewer",
  ]
  metadata = jsonencode({
    "foo" = "bar"
  })
}

resource "elasticstack_elasticsearch_security_user" "bar" {
  username = "bar"
  password = "asdfasdf"
  roles = [
    "viewer",
  ]
  metadata = jsonencode({
    "foo" = "bar"
  })
}
