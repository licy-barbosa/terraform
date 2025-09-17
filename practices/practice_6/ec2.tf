resource "aws_instance" "public_instance" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  provider               = aws.ohio
  key_name               = data.aws_key_pair.key_practice.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

  user_data = file("scripts/userdata.sh")

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