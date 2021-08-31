# terraform-packer
## AIM
To create a custom AWS AMI using Packer.
1- Packer AMI consist of the following features:
  - Fully patched
  - Docker and Docker-Compose will be already Installed
  - Git Installation
  - Source code of Node-JS application
  - Running Docker containers with three different containers for frontend, backend and postgres.
2- Terraform script will Provision EC2, SG, Application LoadBalancer and other required resources.

## Steps to Reproduce
 - Run packer file with the following command:
       ` packer validate packer.json`
       ` packer build packer.json`
 - Run terraform script
## Variables
- In Packer File:
    1- Aws access_key, secret_key, region, ami_name, source_ami, instance_type, ssh_username
- In Terraform File:
    1- Aws access_key, secret_key, region, key_name, instance_type, security_group
