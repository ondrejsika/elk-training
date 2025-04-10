resource "elasticstack_kibana_import_saved_objects" "settings" {
  overwrite     = true
  space_id      = elasticstack_kibana_space.tf.space_id
  file_contents = file("traefik-dashboard.ndjson")
}
