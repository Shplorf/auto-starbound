# Uncomment if you populated these variables instead of using environment vars
# provider "aws" {
#     access_key = "${var.access_key}"
#     secret_key = "${var.secret_key}"
#     region = "${var.region}"
# }

resource "aws_security_group" "ssh_and_factorio" {
  name = "ssh_and_factorio"
  description = "Allow ssh and factorio traffic"

  ingress {
      from_port = 21025
      to_port = 21025
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "starbound-server" {
    ami = "${var.ec2_ami}"
    instance_type = "t2.medium"
    key_name = "${var.key_pair_name}"
    vpc_security_group_ids = ["${aws_security_group.ssh_and_factorio.id}"]
    tags {
        Name = "Starbound-Server"
        Role = "starbound"
    }
    root_block_device {
      volume_size = "40"
    }
    provisioner "remote-exec" {
        inline = ["# Connected!"]
        connection {
            user = "${var.user}"
            private_key = "${file(var.private_key_path)}"
        }
    }
}