# module "s3" {
#   source      = "./modules/s3"
#   bucket_name = "terraform-state"
# }


# resource "null_resource" "method-delay" {
#   provisioner "local-exec" {
#     command = "sleep 5"
#   }
#   triggers = {
#     response = aws_api_gateway_resource.courses.id
#   }
# }

module "dynamo_db_courses" {
  source  = "./modules/dynamodb/eu-central-1"
  context = module.label.context
  name    = "courses"
}

module "dynamo_db_authors" {
  source  = "./modules/dynamodb/eu-central-1"
  context = module.label.context
  name    = "authors"
}



module "iam" {
  source            = "./modules/iam/eu-central-1"
  context           = module.label.context
  name              = "iam"
  table_authors_arn = module.dynamo_db_authors.table_arn
  table_courses_arn = module.dynamo_db_courses.table_arn
}

module "lambda" {
  source                          = "./modules/lambda/eu-central-1"
  context                         = module.label.context
  get_all_authors_name            = "get-all-authors"
  get_all_courses_name            = "get-all-courses"
  get_course_name                 = "get-course"
  post_course_name                = "post-course"
  update_course_name              = "update-course"
  delete_course_name              = "delete-course"
  table_authors_name              = module.dynamo_db_authors.table_name
  table_authors_arn               = module.dynamo_db_authors.table_arn
  table_courses_name              = module.dynamo_db_courses.table_name
  table_courses_arn               = module.dynamo_db_courses.table_arn
  lambda_get_all_authors_role_arn = module.iam.table_get_all_authors_role_arn
  lambda_get_all_courses_role_arn = module.iam.table_get_all_courses_role_arn
  lambda_get_course_role_arn      = module.iam.table_get_course_role_arn
  lambda_post_course_role_arn     = module.iam.table_put_course_role_arn
  lambda_update_course_role_arn   = module.iam.table_put_course_role_arn //table_update_course_role_arn
  lambda_delete_course_role_arn   = module.iam.table_delete_course_role_arn
}

module "s3_bucket" {
  source  = "./modules/s3/eu-central-1"
  context = module.label.context
  name    = "frontend"
}

module "alarm" {
  for_each = tomap(
    {
      authors_function_name = module.lambda.lambda_authors_function_name,
      get_all_courses_function_name = module.lambda.lambda_get_all_courses_function_name,
      get_course_function_name = module.lambda.lambda_get_course_function_name,
      post_course_function_name = module.lambda.lambda_post_course_function_name,
      update_course_function_name = module.lambda.lambda_update_course_function_name,
      delete_course_function_name = module.lambda.lambda_delete_course_function_name,
})
  source = "./modules/cloudwatch/eu-central-1/"
  context = module.label.context
  name = "alarm"
  email = var.email
  # slack_webhook_url = var.slack_webhook_url
  function_name = each.value

}


# little play here, maybe not safe
# and probably spaghetti code:(
resource "local_file" "server_url_config" {
  filename = "frontend/src/api/serverUrl.js"
  content  = "export default \"${aws_api_gateway_deployment.this.invoke_url}${aws_api_gateway_stage.this.stage_name}\";"

}









# resource "aws_s3_object" "object" {
#   for_each = fileset("./frontend/build/", "*")
#   bucket = module.s3_bucket.bucket_name
#   key    = each.value
#   source = "./frontend/build/${each.value}"
# }