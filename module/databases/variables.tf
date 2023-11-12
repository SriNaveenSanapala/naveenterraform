variable "private_subnet_ids" {}
variable "public_subnet_ids" {
  type    = list(string)
  default = []  # Add a default value or replace it with your actual default values
}

# ... rest of the configuration
