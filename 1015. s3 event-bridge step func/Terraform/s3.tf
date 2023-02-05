resource "aws_s3_bucket" "source_bucket" {
    bucket = "${var.source_bucket_name}"
}

resource "aws_s3_bucket_notification" "MyS3BucketNotification" {
  bucket      = aws_s3_bucket.source_bucket.id
  eventbridge = true
}