resource "aws_vpc" "vpc_Virginia" {
  cidr_block = "10.10.0.0/16"
  provider = aws.virginia

  tags = {
    Name = "vpc-virginia"
    Owner        = "ElizabethB"
    Environment = "Dev"
  }
}

resource "aws_vpc" "vpc_Ohio" {
  cidr_block = "10.20.0.0/16"
  provider = aws.ohio

  tags = {
    Name = "vpc_ohio"
    Owner        = "ElizabethB"
    Environment = "Dev"
  }
}