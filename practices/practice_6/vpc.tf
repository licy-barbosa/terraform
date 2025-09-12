resource "aws_vpc" "vpc_ohio" {
  cidr_block = var.ohio_cidr
  provider   = aws.ohio

  tags = {
    "Name" = "vpc_ohio" #agregando el tag Name a la VPC 
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_ohio.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true #tiene que poder asignar direcciones publicas automáticamente
  provider                = aws.ohio

  tags = {
    "Name" = "Public subnet "
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_ohio.id
  cidr_block = var.private_subnet_cidr
  provider   = aws.ohio

  tags = {
    "Name" = "private subnet " #agregando el tag Name a la VPC 
  }

  depends_on = [aws_subnet.public_subnet] #asegura que la subred publica se cree antes que la privada
}