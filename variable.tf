variable "aws_region" {
  default =  "ap-south-1"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "subnet" {
  type = "list"
  default = ["10.0.1.0/24","10.0.2.0/24"]
}
variable "azs" {
  type = "list"
  default = ["ap-south-1a","ap-south-1b"]
}
variable "instance_type"  {
  default = "t2.micro"
}
variable "project" {
  default = "Dev"
}
