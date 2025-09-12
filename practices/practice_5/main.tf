resource "aws_vpc" "vpc_Virginia" {
  cidr_block = var.virginia_cidr
  provider = aws.virginia

  tags = {
    Name = "vpc-virginia"
    Owner        = "ElizabethB"
    Environment = "Dev"
  }
}

resource "aws_vpc" "vpc_Ohio" {
  cidr_block = var.ohio_cidr
  provider = aws.ohio

  tags = {
    Name = "vpc_ohio"
    Owner        = "ElizabethB"
    Environment = "Dev"
  }
}