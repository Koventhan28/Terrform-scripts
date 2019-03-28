resource "aws_vpc" "myvpc" {
  # The below line is used for providing instance with public dns name
  enable_dns_hostnames = "true"
  cidr_block = "${var.vpc_cidr}"
  #enable_classiclink = true
  tags{
    name = "VPC"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = "${aws_vpc.myvpc.id}"
    tags{
      name = "Internet_gateway"
    }
}



resource "aws_subnet" "public" {
  count = "${length(var.subnet)}"
  cidr_block = "${element(var.subnet,count.index)}"
  availability_zone = "${element(var.azs,count.index)}"
  vpc_id = "${aws_vpc.myvpc.id}"
  map_public_ip_on_launch ="true"
  tags {
     name=  "Public-subnet"
   }
 }
   resource "aws_route_table" "route_table" {
     vpc_id = "${aws_vpc.myvpc.id}"
     route {
       cidr_block = "0.0.0.0/0"
       gateway_id = "${aws_internet_gateway.internet_gateway.id}"
     }
   }

   resource "aws_route_table_association" "route_table_associate" {
     count = "${length(var.subnet)}"
     subnet_id = "${element(aws_subnet.public.*.id , count.index)}"
     route_table_id = "${aws_route_table.route_table.id}"
   }
