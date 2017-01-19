#####################################
# VPC Settings
#####################################
resource "aws_vpc" "vpc" {
    cidr_block = "${var.root_segment}"
    tags {
        Name = "${var.app_name} vpc"
        Group = "${var.app_name}"
    }
}

#####################################
# Internet Gateway Settings
#####################################
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
        Name = "${var.app_name} igw"
        Group = "${var.app_name}"
    }
}

#####################################
# Public Subnets Settings
#####################################
resource "aws_subnet" "public-subnet1" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.public_segment1}"
    availability_zone = "${var.az1}"
    tags {
        Name = "${var.app_name} public-subnet1"
        Group = "${var.app_name}"
    }
}
resource "aws_subnet" "public-subnet2" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.public_segment2}"
    availability_zone = "${var.az1}"
    tags {
        Name = "${var.app_name} public-subnet2"
        Group = "${var.app_name}"
    }
}

#####################################
# Private Subnets Settings
#####################################
resource "aws_subnet" "private-subnet1" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.private_segment1}"
    availability_zone = "${var.az1}"
    tags {
        Name = "${var.app_name} private-subnet1"
        Group = "${var.app_name}"
    }
}

resource "aws_subnet" "private-subnet2" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.private_segment2}"
    availability_zone = "${var.az2}"
    tags {
        Name = "${var.app_name} private-subnet2"
        Group = "${var.app_name}"
    }
}

#####################################
# EIP Settings
#####################################
resource "aws_eip" "eip1" {
}
resource "aws_eip" "eip2" {
}

#####################################
# NAT Gateway Settings
#####################################
resource "aws_nat_gateway" "ngw1" {
    allocation_id = "${aws_eip.eip1.id}"
    subnet_id = "${aws_subnet.public-subnet1.id}"

    depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_nat_gateway" "ngw2" {
    allocation_id = "${aws_eip.eip2.id}"
    subnet_id = "${aws_subnet.public-subnet2.id}"

    depends_on = ["aws_internet_gateway.igw"]
}
