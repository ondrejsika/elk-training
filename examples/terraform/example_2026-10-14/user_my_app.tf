resource "elasticstack_elasticsearch_security_user" "my_app_ro" {
  username = "my-app-ro"

  password_wo = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.my_app_ro.name,
  ]
}

resource "elasticstack_elasticsearch_security_user" "my_app_wo" {
  username = "my-app-wo"

  password_wo = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.my_app_wo.name,
  ]
}
