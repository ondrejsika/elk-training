resource "elasticstack_kibana_space" "kubernetes" {
  space_id = "kubernetes"
  name     = "Kubernetes Space"
  initials = "K"
  solution = "oblt"
}
