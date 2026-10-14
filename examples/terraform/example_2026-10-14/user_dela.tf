resource "elasticstack_elasticsearch_security_user" "dela" {
  username = "dela"

  password_wo = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.global_ro.name,
  ]
}
