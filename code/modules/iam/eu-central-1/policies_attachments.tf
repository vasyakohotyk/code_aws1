resource "aws_iam_role_policy_attachment" "read_table_authors" {
  for_each = tomap({
    function_logging_policy = aws_iam_policy.function_logging_policy.arn,
    read_table_authors      = aws_iam_policy.read_table_authors.arn
  })
  policy_arn = each.value
  role       = aws_iam_role.read_table_authors.name
}

resource "aws_iam_role_policy_attachment" "read_table_courses" {
  for_each = tomap({
    function_logging_policy = aws_iam_policy.function_logging_policy.arn,
    read_table_courses      = aws_iam_policy.read_table_courses.arn
  })
  policy_arn = each.value
  role       = aws_iam_role.read_table_courses.name
}

resource "aws_iam_role_policy_attachment" "get_course" {
  for_each = tomap({
    function_logging_policy = aws_iam_policy.function_logging_policy.arn,
    get_course              = aws_iam_policy.get_course.arn
  })
  role       = aws_iam_role.get_course.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "put_course" {
  for_each = tomap({
    function_logging_policy = aws_iam_policy.function_logging_policy.arn,
    put_course              = aws_iam_policy.put_course.arn
  })
  role       = aws_iam_role.put_course.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "update_course" {
  for_each = tomap({
    function_logging_policy = aws_iam_policy.function_logging_policy.arn,
    update_course           = aws_iam_policy.update_course.arn
  })
  role       = aws_iam_role.update_course.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "delete_course" {
  for_each = tomap({
    function_logging_policy = aws_iam_policy.function_logging_policy.arn,
    delete_course           = aws_iam_policy.delete_course.arn
  })
  role       = aws_iam_role.delete_course.name
  policy_arn = each.value
}
