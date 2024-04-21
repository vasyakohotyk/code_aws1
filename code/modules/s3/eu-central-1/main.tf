module "label" {
  source  = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.24.1"
  context = var.context
  name    = var.name
}

# resource "aws_s3_bucket" "this" {
#   bucket = "${module.label.id}${module.label.delimiter}bucket"

#   tags = {
#     Name        = module.label.name
#     Environment = module.label.environment
#   }
# }


module "s3_bucket_frontend" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "3.9.0"

  bucket = module.label.id
  versioning = {
    enabled = false
  }
} 
