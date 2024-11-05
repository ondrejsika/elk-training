terraform {
  required_providers {
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "0.11.11"
    }
  }
}
provider "elasticstack" {
  elasticsearch {
    username  = "elastic"
    password  = "q3fv4NT1YB7L0yL4X27M30WI"
    endpoints = ["https://es.k8s.sikademo.com:443"]
  }
  kibana {
    username  = "elastic"
    password  = "q3fv4NT1YB7L0yL4X27M30WI"
    endpoints = ["https://kb.k8s.sikademo.com:443"]
  }
}
