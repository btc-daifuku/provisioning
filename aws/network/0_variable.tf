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
  default = "t2.micro"
}
