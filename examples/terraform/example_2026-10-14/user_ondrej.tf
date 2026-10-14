resource "elasticstack_elasticsearch_security_user" "ondrej" {
  username = "ondrej"

  password_wo = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.global_ro.name,
  ]
}
