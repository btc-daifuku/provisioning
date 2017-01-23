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
    map_public_ip_on_launch = true
    tags {
        Name = "${var.app_name} public-subnet1"
        Group = "${var.app_name}"
    }
}
resource "aws_subnet" "public-subnet2" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.public_segment2}"
    availability_zone = "${var.az2}"
    map_public_ip_on_launch = true
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
resource "aws_nat_gateway" "natgw1" {
    allocation_id = "${aws_eip.eip1.id}"
    subnet_id = "${aws_subnet.public-subnet1.id}"

    depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_nat_gateway" "natgw2" {
    allocation_id = "${aws_eip.eip2.id}"
    subnet_id = "${aws_subnet.public-subnet2.id}"

    depends_on = ["aws_internet_gateway.igw"]
}

#####################################
# Public Routes Table Settings
#####################################
resource "aws_route_table" "public-root-table" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }
    tags {
        Name = "${var.app_name} public-root-table"
        Group = "${var.app_name}"
    }
}

resource "aws_route_table_association" "public-rta1" {
    subnet_id = "${aws_subnet.public-subnet1.id}"
    route_table_id = "${aws_route_table.public-root-table.id}"
}

resource "aws_route_table_association" "public-rta2" {
    subnet_id = "${aws_subnet.public-subnet2.id}"
    route_table_id = "${aws_route_table.public-root-table.id}"
}

#####################################
# Private Routes Table Settings
#####################################
resource "aws_route_table" "private-root-table1" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.natgw1.id}"
    }
    tags {
        Name = "${var.app_name} private-root-table1"
        Group = "${var.app_name}"
    }
}

resource "aws_route_table_association" "private-rta1" {
    subnet_id = "${aws_subnet.private-subnet1.id}"
    route_table_id = "${aws_route_table.private-root-table1.id}"
}

resource "aws_route_table" "private-root-table2" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.natgw2.id}"
    }
    tags {
        Name = "${var.app_name} private-root-table2"
        Group = "${var.app_name}"
    }
}

resource "aws_route_table_association" "private-rta2" {
    subnet_id = "${aws_subnet.private-subnet2.id}"
    route_table_id = "${aws_route_table.private-root-table2.id}"
}
