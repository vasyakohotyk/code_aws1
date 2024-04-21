output "table_get_all_authors_role_arn" {
    value = aws_iam_role.read_table_authors.arn
}
output "table_get_all_courses_role_arn" {
    value = aws_iam_role.read_table_courses.arn
}
output "table_get_course_role_arn" {
    value = aws_iam_role.get_course.arn
}
output "table_put_course_role_arn" {
    value = aws_iam_role.put_course.arn
}
output "table_update_course_role_arn" {
    value = aws_iam_role.update_course.arn
}
output "table_delete_course_role_arn" {
    value = aws_iam_role.delete_course.arn
}