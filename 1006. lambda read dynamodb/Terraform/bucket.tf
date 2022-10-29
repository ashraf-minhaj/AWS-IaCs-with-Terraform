resource "aws_s3_bucket" "s3_bucket" {
    bucket = "${var.bucket_name}"  
}

# making the s3 bucket private 
resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}