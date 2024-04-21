resource "aws_iam_policy" "function_logging_policy" {
  name   = "function-logging-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect : "Allow",
        Resource : "arn:aws:logs:*:*:*"
      }
    ]
  })
}

#Courses table

data "aws_iam_policy_document" "read_table_courses" {
  statement {
    actions = [
      "dynamodb:Scan",
    ]

    resources = [
      var.table_courses_arn
    ]
  }
}
resource "aws_iam_policy" "read_table_courses" {
  name   = "${module.label_table_courses.id}-read"
  path   = "/"
  policy = data.aws_iam_policy_document.read_table_courses.json
}


data "aws_iam_policy_document" "get_course" {
  statement {
    actions = [
      "dynamodb:GetItem",
    ]

    resources = [
      var.table_courses_arn
    ]
  }
}
resource "aws_iam_policy" "get_course" {
  name   = "${module.label_table_courses.id}-get"
  path   = "/"
  policy = data.aws_iam_policy_document.get_course.json

}
# ssxwsx

data "aws_iam_policy_document" "put_course" {
  statement {
    actions = [
      "dynamodb:PutItem",
    ]

    resources = [
      var.table_courses_arn
    ]
  }
}
resource "aws_iam_policy" "put_course" {
  name   = "${module.label_table_courses.id}-put"
  path   = "/"
  policy = data.aws_iam_policy_document.put_course.json

}


data "aws_iam_policy_document" "update_course" {
  statement {
    actions = [
      "dynamodb:UpdateItem",
      "dynamodb:PutItem",
    ]

    resources = [
      var.table_courses_arn
    ]
  }
}
resource "aws_iam_policy" "update_course" {
  name   = "${module.label_table_courses.id}-update"
  path   = "/"
  policy = data.aws_iam_policy_document.update_course.json

}

data "aws_iam_policy_document" "delete_course" {
  statement {
    actions = [
      "dynamodb:DeleteItem",
    ]
    resources = [
      var.table_courses_arn
    ]
  }
}
resource "aws_iam_policy" "delete_course" {
  name   = "${module.label_table_courses.id}-delete"
  path   = "/"
  policy = data.aws_iam_policy_document.delete_course.json

}




# Authors table

data "aws_iam_policy_document" "read_table_authors" {
  statement {
    actions = [
      "dynamodb:Scan",
    ]

    resources = [
      var.table_authors_arn
    ]
  }
  
}
resource "aws_iam_policy" "read_table_authors" {
  name   = "${module.label_table_authors.id}-read"
  path   = "/"
  policy = data.aws_iam_policy_document.read_table_authors.json

}

# data "aws_iam_policy_document" "get_author" {
#   statement {
#     actions = [
#       "dynamodb:GetItem",
#     ]

#     resources = [
#       var.table_authors_arn
#     ]
#   }
# }
# resource "aws_iam_policy" "get_author" {
#   name   = module.label_table_authors.id
#   path   = "/"
#   policy = data.aws_iam_policy_document.get_author.json
# }


# data "aws_iam_policy_document" "put_author" {
#   statement {
#     actions = [
#       "dynamodb:putItem",
#     ]

#     resources = [
#       var.table_authors_arn
#     ]
#   }
# }
# resource "aws_iam_policy" "put_author" {
#   name   = module.label_table_authors.id
#   path   = "/"
#   policy = data.aws_iam_policy_document.put_author.json
# }

# data "aws_iam_policy_document" "update_author" {
#   statement {
#     actions = [
#       "dynamodb:UpdateItem",
#     ]

#     resources = [
#       var.table_authors_arn
#     ]
#   }
# }
# resource "aws_iam_policy" "update_author" {
#   name   = module.label_table_authors.id
#   path   = "/"
#   policy = data.aws_iam_policy_document.update_author.json
# }

# data "aws_iam_policy_document" "delete_author" {
#   statement {
#     actions = [
#       "dynamodb:DeleteItem",
#     ]

#     resources = [
#       var.table_authors_arn
#     ]
#   }
# }
# resource "aws_iam_policy" "delete_author" {
#   name   = module.label_table_authors.id
#   path   = "/"
#   policy = data.aws_iam_policy_document.delete_author.json
# }