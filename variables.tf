variable "region" {
    default = "us-east-1"
}
variable "ec2_ami" {
  default = "ami-cbdd50dc"
}
variable "key_pair_name" {}
variable "private_key_path" {}
variable "user" {
	default = "ubuntu"
}