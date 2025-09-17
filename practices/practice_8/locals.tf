# v.44
locals {
  sufix  = "${var.tags.project}-${var.tags.env}" #recurso-cerberus-prod-region
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  random_sufix = "${var.tags.project}-${random_string.suffix.id}"
}   