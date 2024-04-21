data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "read_table_courses" {
  name               = "${module.label_table_courses.id}-read"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
resource "aws_iam_role" "get_course" {
  name               = "${module.label_table_courses.id}-get"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
resource "aws_iam_role" "put_course" {
  name               = "${module.label_table_courses.id}-put"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
resource "aws_iam_role" "update_course" {
  name               = "${module.label_table_courses.id}-update"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
resource "aws_iam_role" "delete_course" {
  name               = "${module.label_table_courses.id}-delete"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}


resource "aws_iam_role" "read_table_authors" {
  name               = "${module.label_table_authors.id}-read"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
# resource "aws_iam_role" "get_author" {
#   name               = module.label_table_authors.id
#   path               = "/"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
# }
# resource "aws_iam_role" "put_author" {
#   name               = module.label_table_authors.id
#   path               = "/"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
# }
# resource "aws_iam_role" "update_author" {
#   name               = module.label_table_authors.id
#   path               = "/"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
# }
# resource "aws_iam_role" "delete_author" {
#   name               = module.label_table_authors.id
#   path               = "/"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
# }

