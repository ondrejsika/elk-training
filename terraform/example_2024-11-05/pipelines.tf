resource "elasticstack_elasticsearch_ingest_pipeline" "dissect" {
  name = "dissect"
  processors = [
    <<EOF
    {
    "set": {
      "field": "message2",
      "copy_from": "message"
    }
  }
    EOF
    ,
    file("dissect.json"),
  ]
}
