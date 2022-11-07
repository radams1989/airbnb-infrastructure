resource "aws_s3_bucket" "MyBucket" {
    bucket = var.bucket_name 
}

resource "aws_s3_bucket_public_access_block" "access_MyBucket" {
  bucket = aws_s3_bucket.MyBucket.id

  block_public_acls   = true
  block_public_policy = true
}