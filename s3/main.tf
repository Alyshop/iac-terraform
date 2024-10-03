resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "delete-old-objects"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
