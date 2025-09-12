resource "aws_instance" "public_instance" {
  ami           = "ami-0634f3c109dcdc659"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  provider      = aws.ohio
  key_name      = data.aws_key_pair.key_practice.key_name


  lifecycle {
    # v 34
    #create_before_destroy = true  # primero crea la nueva instancia y luego destruye la antigua
    #prevent_destroy       = true # no destruir nunta esta instancia
    #ignore_changes        = [tags] # ignora los cambios en las etiquetas
    #replace_triggered_by  = [aws_ebs_volume.vol1] # si este recurso cambia, reemplaza esta instancia
  }

  tags = {
    "Name" = "Public instance"
  }
}