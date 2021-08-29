data "aws_ami" "ami"{
    most_recent = true
    name_regex = "^Node-AMI"
    owners = [ "self" ]
}
data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["vpc"]
  }
}
data "aws_subnet_ids" "subnet_ids" {
  vpc_id = data.aws_vpc.selected.id
}