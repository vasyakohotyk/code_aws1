output "sync_front"{
  value = "aws s3 sync ./frontend/build/ s3://${module.s3_bucket.bucket_name}"
}
output "aws_api_execution_arn" {
  value = "${aws_api_gateway_deployment.this.invoke_url}${aws_api_gateway_stage.this.stage_name}"
}