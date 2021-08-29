variable "aws_region" {
       description = "The AWS region to create things in." 
       default     = "us-west-1" 
}

variable "access_key" {
       description = "The AWS access key." 
       default     = "AKIA3XPXKQGK44GWTNFF" 
}
variable "secret_key" {
       description = "The AWS secret key." 
       default     = "TDEHzPWzY9zYTk7tzj6iXSqdi+t7X2qvHCBJIKrd" 
}
variable "key_name" { 
    description = " SSH keys to connect to ec2 instance" 
    default     =  "tester" 
}

variable "instance_type" { 
    description = "instance type for ec2" 
    default     =  "t2.micro" 
}

variable "security_group" { 
    description = "Name of security group" 
    default     = "my-security-group" 
}

variable "tag_name" { 
    description = "Tag Name of for Ec2 instance" 
    default     = "my-ec2-instance" 
} 
