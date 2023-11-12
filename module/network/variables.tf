variable "vpc_cidr_block" {}
variable "availability_zones" {}


variable "vpc_name" {
  type    = string
  default = ""
}

variable "public_subnet_names" {
  type    = list(string)
  default = []
}

variable "private_subnet_names" {
  type    = list(string)
  default = []
}

variable "igw_name" {
  type    = string
  default = ""
}

variable "public_route_table_name" {
  type    = string
  default = ""
}

variable "private_route_table_name" {
  type    = string
  default = ""
}
# ./module/network/variables.tf

variable "create_internet_gateway" {
  type    = bool
  default = true
}

# ... rest of the variable declarations
