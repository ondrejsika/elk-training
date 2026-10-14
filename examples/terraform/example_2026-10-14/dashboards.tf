locals {
  my_app_dashboad_spaces = [
    elasticstack_kibana_space.global.id,
    elasticstack_kibana_space.my_app.id,
  ]
}

resource "elasticstack_kibana_import_saved_objects" "my_app" {
  count = length(local.my_app_dashboad_spaces)

  overwrite     = true
  space_id      = local.my_app_dashboad_spaces[count.index]
  file_contents = file("./dashboards/my_app_dashboad.ndjson")
}
