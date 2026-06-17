variable "vpc_cidr_block" {
  description = "VPC Subnet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet" {
  description = "VPC Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ssh_home_ip" {
  description = "Allow SSH to home IP"
  type        = string
  default     = "0.0.0.0/32"
  sensitive   = true
}

variable "instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t3.medium"
}

variable "public_key_content" {
  description = "SSH Public Key"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp9C6jU9v/Ksq/avRQpmMAGMZt3/tjpAYZ97r53l0rv mighty@DESKTOP-JDMTS14"
}

variable "is_pipeline" {
  type        = bool
  default     = false
  description = "Set to true when running inside CI/CD to bypass local profiles."
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID."
}