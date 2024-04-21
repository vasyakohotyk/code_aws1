module "label_table_courses" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = "${var.name}-courses"
}
module "label_table_authors" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = "${var.name}-authors"
}





