# for_each example
# variable "instances_count" {
#   description = "Nombre de instancias EC2 a crear"
#   type        = set(string)
#   default     = [ "mysql", "jumpserver"]
# }

# resource "aws_instance" "public_instance" {
#   for_each               = var.instances_count
#   ami                    = var.ec2_specs.ami
#   instance_type          = var.ec2_specs.instance_type
#   subnet_id              = aws_subnet.public_subnet.id
#   provider               = aws.ohio
#   key_name               = data.aws_key_pair.key_practice.key_name
#   vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

#   user_data = file("scripts/userdata.sh")

#   tags = {
#     "Name" = "${each.value} -${local.sufix}"
#   }
# }

# condicional example v.43
variable "instances_count" {
  description = "Nombre de instancias EC2 a crear"
  type        = list(string)
  //default     = [ "mysql", "jumpserver"]
  default     = [ "apache"]
}

resource "aws_instance" "monitoring_instance" {
  #count                  = var.enable_monitoring == 1 ? 1 : 0
  count                  = var.enable_monitoring ? 1:0
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  provider               = aws.ohio
  key_name               = data.aws_key_pair.key_practice.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

  user_data = file("scripts/userdata.sh")

  tags = {
    "Name" = "monitoring-instance -${local.sufix}"
  }
}