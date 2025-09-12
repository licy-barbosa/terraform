# tipos de variables
# string, number, bool, any, 
# list: conjunto de elementos del mismo tipo
# map: llave, valor  
# set: no admiten duplicados y al utilizarlo se deben utilizar todos los elementos
# object: conjunto de variables con tipos definidos
# tuple: conjunto de variables con tipos definidos pero no necesariamente iguales
# v. 22

variable "virginia_cidr" {
  type        = string
  description = "  cidr_block for the Virginia VPC"
  sensitive   = flase # si es true no se muestra en los planes
}

variable "ohio_cidr" {
  type        = string
  description = "  cidr_block for the Ohio VPC"
}