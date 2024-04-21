module "label" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = var.name
}

module "label_get_all_authors" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = var.get_all_authors_name
}
module "label_get_all_courses" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = var.get_all_courses_name
}
module "label_get_course" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = var.get_course_name
}
module "label_post_course" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = var.post_course_name
}
module "label_update_course" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = var.update_course_name
}
module "label_delete_course" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  context  = var.context
  name     = var.delete_course_name
}

module "lambda_get_all_authors" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = module.label_get_all_authors.id
  description = "Get all authors"
  handler = "index.handler"
  runtime = "nodejs16.x"
  source_path = "${path.module}/lambda_src/get_all_authors/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_authors_name
  }

  create_role = false
  lambda_role = var.lambda_get_all_authors_role_arn

  tags = module.label_get_all_authors.tags
}
module "lambda_get_all_courses" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = module.label_get_all_courses.id
  description = "Get all courses"
  handler = "index.handler"
  runtime = "nodejs16.x"
  source_path = "${path.module}/lambda_src/get_all_courses/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_get_all_courses_role_arn

  tags = module.label_get_all_courses.tags
}

module "lambda_get_course" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = module.label_get_course.id
  description = "Get course"
  handler = "index.handler"
  runtime = "nodejs16.x"
  source_path = "${path.module}/lambda_src/get_course/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_get_course_role_arn

  tags = module.label_get_course.tags
}

module "lambda_post_course" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = module.label_post_course.id
  description = "post course"
  handler = "index.handler"
  runtime = "nodejs16.x"
  source_path = "${path.module}/lambda_src/post_course/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_post_course_role_arn

  tags = module.label_post_course.tags
}

module "lambda_update_course" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = module.label_update_course.id
  description = "Update course"
  handler = "index.handler"
  runtime = "nodejs16.x"
  source_path = "${path.module}/lambda_src/update_course/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_update_course_role_arn

  tags = module.label_update_course.tags
}

module "lambda_delete_course" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.13.0"
  function_name = module.label_delete_course.id
  description = "Delete course"
  handler = "index.handler"
  runtime = "nodejs16.x"
  source_path = "${path.module}/lambda_src/delete_course/index.js"
  
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  create_role = false
  lambda_role = var.lambda_delete_course_role_arn

  tags = module.label_delete_course.tags
}