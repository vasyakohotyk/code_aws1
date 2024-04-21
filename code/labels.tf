module "label" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.24.1"
  namespace = var.namespace
  stage     = var.stage
  delimiter = var.delimiter
}
module "label_api" {
  source = "cloudposse/label/null"
  version = "0.25.0"

  name = "api"
  context = module.label.context
}
