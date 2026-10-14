resource "elasticstack_kibana_space" "global" {
  space_id = "global"
  name     = "Global Space"
  initials = "G"
  solution = "oblt"
}
