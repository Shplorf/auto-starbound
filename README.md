Automated Starbound Server Setup
================================

This project's goal is to automate the setup of a Starbound dedicated server as much as possible.

Using Terraform, the server is created in AWS EC2 and access to it is limited to SSH and port 21025 (that Starbound communicates on).

After Terraform is finished bringing up the instance, it invokes Ansible to configure and start up the Starbound server.

Afterwards, you can run additional Ansible commands to update the server as well as backup and restore your universe from S3.

The Ansible role I use is my own: [Shplorf.starbound](https://github.com/Shplorf/ansible-starbound)

Requirements
------------
- SSH key generated in AWS and present locally, to enable Ansible and Terrafrom to SSH into the server.
- Ansible and Terraform installed and configured to work with AWS:
  - [Install Ansible](https://docs.ansible.com/ansible/intro_installation.html)
  - [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
  - [Configure Ansible](https://aws.amazon.com/blogs/apn/getting-started-with-ansible-and-dynamic-amazon-ec2-inventory-management/)
  - [Configure Terraform](https://www.terraform.io/docs/providers/aws/)

Terraform Variables
-------------------
- ```variable "region" {default = "us-east-1"}```
AWS EC2 Region for your instance
- ```variable "ec2_ami" {default = "ami-cbdd50dc"}```
Ubuntu AMI that the instance will be based on. Defaults to Ubuntu 14.04.5 LTS (Trusty Tahr). Nothing else is currently supported.
- ```variable "user" {default = "ubuntu"}```
The user that will be used to poll for an ssh connection after the server is created.
- ```variable "key_pair_name" {}```
The name of the key pair in AWS that you wish to associate with the instance
- ```variable "private_key_path" {}```
The path to your private key file. Used to poll for an ssh connection after the server is created.

Ansible Variables
-----------------
See README for [Shplorf.starbound](https://github.com/Shplorf/ansible-starbound)

Usage
-----
When everything is configured, you can simply run
```terraform apply```
After it finishes setting up your server, you should be able to connect to its IP from Starbound right away.

License
-------
MIT
