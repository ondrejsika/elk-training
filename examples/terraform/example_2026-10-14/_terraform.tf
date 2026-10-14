terraform {
  required_providers {
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "0.16.5"
    }
  }
}

variable "elastic_password" {
  default   = "elastic"
}

provider "elasticstack" {
  elasticsearch {
    username  = "elastic"
    password  = var.elastic_password
    endpoints = ["https://es.k8s.sikademo.com:443"]
  }
  kibana {
    username  = "elastic"
    password  = var.elastic_password
    endpoints = ["https://kb.k8s.sikademo.com:443"]
  }
}
