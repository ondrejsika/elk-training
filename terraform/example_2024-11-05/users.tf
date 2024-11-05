resource "elasticstack_elasticsearch_security_user" "bbb" {
  username = "bbb"

  password = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.traefik-read.name,
  ]
}

resource "elasticstack_elasticsearch_security_user" "tf" {
  username = "tf"

  password = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.tf.name,
  ]
}

resource "elasticstack_elasticsearch_security_user" "ccc" {
  username = "ccc"

  password = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.traefik-rw.name,
  ]
}
