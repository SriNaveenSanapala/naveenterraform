variable "vpc_id" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}

resource "aws_instance" "example" {
  ami           = "ami-0e8a34246278c21e4 "
  instance_type = "t2.micro"
  count         = 2

  subnet_id = element(var.private_subnet_ids, count.index % length(var.private_subnet_ids))

  # other instance configurations...
}

# ... other configurations
