# tipos de variables
# string, number, bool, any, 
# list: conjunto de elementos del mismo tipo
# map: llave, valor  
# set: no admiten duplicados y al utilizarlo se deben utilizar todos los elementos
# object: conjunto de variables con tipos definidos
# tuple: conjunto de variables con tipos definidos pero no necesariamente iguales
# v. 22

variable "ohio_cidr" {
  type        = string
  description = "  cidr_block for the Ohio VPC"
  sensitive   = false # muestra el valor en la salida
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR PUBLIC SUBNET"
  sensitive   = false # muestra el valor en la salida
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR PRIVATE SUBNET"
  sensitive   = false # muestra el valor en la salida
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}