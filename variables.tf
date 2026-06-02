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
  default     = "t3.micro"
}

variable "public_key_content" {
  description = "SSH Public Key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCx5ggOck51Tj/M1kRfuWOHS49rjTy1HZB+Q32vwwz04ZZfJPwNJBA8jbtYl8/89bT0OFo/Lnw2oEwsQW8QomDEC2R+h50RHW4XpVYXOTjl5Fg7UNKmp4e8SG6o1Ov0DJ2oWacts7ovPzkPW2M2sVk74qzi9MjsmXXggRHdiTWg3//cZKhx4Z9LYSEkE0RxV3bZdTzG5AxVySZiSppvFLBW8rMfNRp7VCLvRF6Hz4lGfk+hpTKIqCYYaSDKJu3aU+hxMtKswwC8xGA9LyexE1W0QoDtBIdiZZQNztR57oeFIR0NkVfEsgNBJe2vxs1a7g1W+0B6wzHgO8iNN5p+ApKEh2jRytPAeQb+jNmrpu3mJMua2iu4sXA9Z50j5upcQlqdV7Zzxg9McVHqiBy4jNI2HiIkcBV9Bhpjboj4M55r9w+ZWS/rRUYeXikVY/w0a0jCXtASj5ZHC85ZYL4l5ag0JqUbzKAwjkeoNYg+JpH3CcTqY+eRHfiT0ifgUKp8LFxN63apueTIiFh6TKdXR5o/qJnnCwUMTVEWd00VahFYssNqpxd5VAf131Et0zWbPFYV1zLRHkFti2bQxo+lImhvaVeUZ4tGbEZkVsgzH10PYCwBcAv2DrdOUxkAcgHVOuUBUsIkJ5aHVlrFOCVp4npenzyC1EEILmrpk2wzFfSZZQ== mighty@DESKTOP-JDMTS14"
}

variable "is_pipeline" {
  type        = bool
  default     = false
  description = "Set to true when running inside CI/CD to bypass local profiles."
}