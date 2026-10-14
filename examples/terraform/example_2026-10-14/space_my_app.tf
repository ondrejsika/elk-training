resource "elasticstack_kibana_space" "my_app" {
  space_id = "my-app"
  name     = "My App Space"
  initials = "MA"
  solution = "oblt"
}
