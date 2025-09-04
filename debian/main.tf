terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region     = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

# 1. Subir la clave pública a AWS
resource "aws_key_pair" "default" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/terraform-key.pub")
}

# 2. Recurso (instancia EC2)
resource "aws_instance" "example" {
  #for_each = var.service_names # crear una instancia por cada nombre en el conjunto
  ami           = "ami-0bb7d855677353076" 
  instance_type = "t3.micro"
  key_name      = aws_key_pair.default.key_name  # <<--- Aquí se asocia la clave pública


  #instalar Docker en la instancia
  user_data = <<-EOF
              #!/bin/bash
              set -e

              # Actualizar sistema
              apt-get update -y
              apt-get upgrade -y

              # Instalar dependencias
              apt-get install -y ca-certificates curl gnupg lsb-release

              # Agregar la clave GPG de Docker
              install -m 0755 -d /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
              chmod a+r /etc/apt/keyrings/docker.gpg

              # Agregar repositorio oficial de Docker
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
                $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

              # Instalar Docker Engine
              apt-get update -y
              apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

              # Habilitar Docker
              systemctl enable docker
              systemctl start docker
              EOF

  tags = {
    Name = "Debian-Docker-Server"
  } 
}