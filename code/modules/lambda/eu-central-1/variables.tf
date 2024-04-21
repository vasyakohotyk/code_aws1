variable "table_authors_name" {
    type = string
}

variable "table_authors_arn" {
    type = string
}


variable "get_all_authors_name" {
    type = string
}

variable "lambda_get_all_authors_role_arn" {
    type = string
}
variable "get_all_courses_name" {
    type = string
}
variable "get_course_name" {
    type = string
}
variable "post_course_name" {
    type = string
}
variable "update_course_name" {
    type = string
}
variable "delete_course_name" {
    type = string
}

variable "table_courses_name" {
    type = string
}

variable "table_courses_arn" {
    type = string
}

variable "lambda_get_all_courses_role_arn" {
    type = string
}
variable "lambda_get_course_role_arn" {
    type = string
}
variable "lambda_post_course_role_arn" {
    type = string
}
variable "lambda_update_course_role_arn" {
    type = string
}
variable "lambda_delete_course_role_arn" {
    type = string
}