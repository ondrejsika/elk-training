locals {
  my_app_is_json = "ctx.message != null && ctx.message.startsWith('{')"
  my_app_is_text = "ctx.message != null && !ctx.message.startsWith('{')"
}

resource "elasticstack_elasticsearch_ingest_pipeline" "my_app" {
  name = "my-app"
  processors = [
    jsonencode({
      set = {
        field = "pipeline"
        value = "my-app/v3"
      }
    }),
    jsonencode({
      "json" : {
        "if" : local.my_app_is_json,
        "field" : "message",
        "target_field" : "message_json",
      }
    }),
    // Text format, eg.:
    // loggen 2026/10/14 15:10:06 ERROR An error ... i=0 pet_kind=rat pet_name=Dela
    jsonencode({
      grok = {
        if    = local.my_app_is_text
        field = "message"
        patterns = [
          "^%%{NOTSPACE:message_json.prefix} (?<message_json.time>%%{YEAR}/%%{MONTHNUM}/%%{MONTHDAY} %%{TIME}) (?<message_json.message>%%{WORD:message_json.level} .*?)(?: (?<message_json._kv>\\w+=\\S+(?: \\w+=\\S+)*))?$",
        ]
      }
    }),
    jsonencode({
      kv = {
        if             = local.my_app_is_text
        field          = "message_json._kv"
        field_split    = " "
        value_split    = "="
        target_field   = "message_json"
        ignore_missing = true
      }
    }),
    jsonencode({
      remove = {
        if             = local.my_app_is_text
        field          = "message_json._kv"
        ignore_missing = true
      }
    }),
    jsonencode({
      convert = {
        if             = local.my_app_is_text
        field          = "message_json.i"
        type           = "integer"
        ignore_missing = true
      }
    }),
    jsonencode({
      lowercase = {
        if    = local.my_app_is_text
        field = "message_json.level"
      }
    }),
    jsonencode({
      date = {
        if            = local.my_app_is_text
        field         = "message_json.time"
        target_field  = "message_json.time"
        formats       = ["yyyy/MM/dd HH:mm:ss"]
        timezone      = "Europe/Prague"
        output_format = "yyyy-MM-dd'T'HH:mm:ssXXX"
      }
    }),
    jsonencode({
      set = {
        field = "kind_name"
        value = "{{ message_json.pet_kind }} {{ message_json.pet_name }}"
      }
    }),
  ]
}
