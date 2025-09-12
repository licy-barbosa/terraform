resource "aws_s3_bucket" "provedores" {
  count = 6
  bucket = "my-tf-provedores-bucket-${random_string.sufijo[count.index].result}"

  tags = {
    Owner        = "ElizabethB"
    Environment = "Dev"
  }
}

resource "random_string" "sufijo"{
    count = 6
    length  = 4
    special = false
    upper   = false
    numeric  = false
}