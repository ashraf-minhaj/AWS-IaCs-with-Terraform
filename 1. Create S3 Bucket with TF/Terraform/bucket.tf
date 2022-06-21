resource "aws_s3_bucket" "demos3" {
    bucket = "${var.bucket_name}" 
    acl = "${var.aws_s3_bucket_acl}"   
}