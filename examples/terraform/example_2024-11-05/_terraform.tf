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
    password  = "elastic"
    endpoints = ["https://es.k8s.sikademo.com:443"]
  }
  kibana {
    username  = "elastic"
    password  = "elastic"
    endpoints = ["https://kb.k8s.sikademo.com:443"]
  }
}
