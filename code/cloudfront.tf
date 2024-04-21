# data "aws_cloudfront_response_headers_policy" "CORS_preflight" {
#   name = "Managed-CORS-with-preflight-and-SecurityHeadersPolicy"
# }

module "cdn" {
  source              = "terraform-aws-modules/cloudfront/aws"
  version             = "3.2.1"
  default_root_object = "index.html"
  comment             = "My awesome CloudFront"
  enabled             = true
  price_class         = "PriceClass_100"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }
  origin = {
    s3_one = {
      domain_name = module.s3_bucket.bucket_domain_name

      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }

  # origin = {
  #   s3_one = {
  #     domain_name = module.s3_bucket.bucket_domain_name
  #     s3_origin_config = {
  #       origin_access_identity = "s3_bucket_one"
  #     }
  #   }
  # }

  default_cache_behavior = {
    target_origin_id           = "s3_one"
    viewer_protocol_policy     = "allow-all"

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  # ordered_cache_behavior = [{
  #   path_pattern               = "/static/*"
  #   target_origin_id           = "s3_one"
  #   viewer_protocol_policy     = "redirect-to-https"

  #   allowed_methods = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods  = ["GET", "HEAD"]
  #   compress        = true
  #   query_string    = true
  # }]

  custom_error_response = [
    {
      error_code            = 404
      response_code         = 200
      response_page_path    = "/index.html"
      error_caching_min_ttl = 10
    },
    {
      error_code            = 403
      response_code         = 200
      response_page_path    = "/index.html"
      error_caching_min_ttl = 10
  }]
}



resource "aws_s3_bucket_policy" "this" {
  bucket = module.s3_bucket.bucket_id
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${module.cdn.cloudfront_origin_access_identity_iam_arns[0]}"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${module.s3_bucket.bucket_arn}/*",
    ]
  }
}
