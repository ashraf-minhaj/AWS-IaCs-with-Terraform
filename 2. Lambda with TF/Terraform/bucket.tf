resource "aws_s3_bucket" "s3_bucket" {
    bucket = "${var.bucket_name}" 
    acl = "${var.aws_s3_bucket_acl}"   
}