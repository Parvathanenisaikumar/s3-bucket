resource "aws_s3_bucket" "b1" {
  bucket = "sai.terraform.bucket"
}

resource "aws_s3_bucket_ownership_controls" "b2" {
  bucket = aws_s3_bucket.b1.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "b2" {
  bucket     = aws_s3_bucket.b1.id
  depends_on = [aws_s3_bucket_ownership_controls.b2]
  acl        = "private"
}

resource "aws_s3_bucket_versioning" "b3" {
  bucket = aws_s3_bucket.b1.id

  versioning_configuration {
    status = "Enabled"
  }
}
