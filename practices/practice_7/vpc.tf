resource "aws_vpc" "vpc_ohio" {
  cidr_block = var.ohio_cidr
  provider   = aws.ohio

  tags = {
    "Name" = "vpc_ohio-${local.sufix}" #agregando el tag Name a la VPC 
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_ohio.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true #tiene que poder asignar direcciones publicas automáticamente
  provider                = aws.ohio

  tags = {
    "Name" = "Public subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_ohio.id
  cidr_block = var.private_subnet_cidr
  provider   = aws.ohio

  tags = {
    "Name" = "private subnet-${local.sufix}" #agregando el tag Name a la VPC 
  }

  depends_on = [aws_subnet.public_subnet] #asegura que la subred publica se cree antes que la privada
}

resource "aws_internet_gateway" "internet_gateway_ohio" {
  vpc_id   = aws_vpc.vpc_ohio.id
  provider = aws.ohio

  tags = {
    "Name" = "Internet gateway VPC Ohio -${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id   = aws_vpc.vpc_ohio.id
  provider = aws.ohio

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_ohio.id
  }

  tags = {
    "Name" = " Public route table crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
  provider       = aws.ohio
}

resource "aws_security_group" "sg_public_instance" {
  name        = "Public instance security group"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_ohio.id
  provider    = aws.ohio

dynamic "ingress"{
    for_each = var.ingress_ports_list
    content {
      description = "Allow inbound traffic on port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
}

#22 es el puesto para administración remota (SSH)
  # ingress {
  #   description = "SSH over internet"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }


  egress {
    description      = "All outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # all protocols
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name" = "Public instance security group-${local.sufix}"
  }
}