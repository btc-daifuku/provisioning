#######################
# Required
#######################

variable "access_key" {}
variable "secret_key" {}

# variable "ssh_key_name" {}

#######################
# Option
#######################

variable "app_name" {
  default = "daifuku"
}

variable "aws_id" {
  default = "734729694574"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "az1" {
  default = "ap-northeast-1a"
}

variable "az2" {
  default = "ap-northeast-1c"
}

variable "root_segment" {
  default = "192.168.0.0/16"
}

variable "public_segment1" {
  default = "192.168.200.0/24"
}

variable "public_segment2" {
  default = "192.168.201.0/24"
}

variable "private_segment1" {
  default = "192.168.100.0/24"
}

variable "private_segment2" {
  default = "192.168.101.0/24"
}

variable "myip" {
  default = "153.156.43.75/32"
}

variable "aws_amis" {
  default = {
      "ap-northeast-1" = "ami-2b08f44a"
  }
}

variable "instance_type" {
  default = "m4.large"
}

#######################
# get current id
#######################

# get vpc id
data "aws_vpc" "selected" {
  filter {
    name   = "tag-value"
    values = ["*${var.app_name}*"]
  }
}

# get subnet id
data "aws_subnet" "public_1" {
  filter {
    name   = "tag-value"
    values = ["*${var.app_name}*public-subnet1*"]
  }
}

data "aws_subnet" "public_2" {
  filter {
    name   = "tag-value"
    values = ["*${var.app_name}*public-subnet2*"]
  }
}

data "aws_subnet" "private_1" {
  filter {
    name   = "tag-value"
    values = ["*${var.app_name}*private-subnet1*"]
  }
}

data "aws_subnet" "private_2" {
  filter {
    name   = "tag-value"
    values = ["*${var.app_name}*private-subnet2*"]
  }
}

# get security group id
data "aws_security_group" "public" {
  filter {
    name   = "tag-value"
    values = ["*${var.app_name}*public-firewall*"]
  }
}

data "aws_security_group" "private" {
  filter {
    name   = "tag-value"
    values = ["*${var.app_name}*private-firewall*"]
  }
}
