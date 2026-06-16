data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "minecraft-key"
  public_key = var.public_key_content
}

resource "aws_instance" "minecraft_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.minecraft_subnet.id
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.minecraft_instance_profile.name
  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = "minecraft-core-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install docker.io docker-compose -y
              systemctl start docker
              systemctl enable docker
              usermod -a -G docker ubuntu
              EOF
}