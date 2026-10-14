resource "elasticstack_elasticsearch_security_user" "kubernetes_ro" {
  username = "kubernetes-ro"

  password_wo = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.kubernetes_ro.name,
  ]
}

resource "elasticstack_elasticsearch_security_user" "kubernetes_wo" {
  username = "kubernetes-wo"

  password_wo = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.kubernetes_wo.name,
  ]
}
