variable "vpc_id" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  count         = 2

  subnet_id = element(var.public_subnet_ids, count.index)

  # other instance configurations...
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}
