# 1. The Security Group container
resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft-server-sg"
  description = "Allow Minecraft and SSH traffic"
  vpc_id      = aws_vpc.minecraft_vpc.id
}

# 2. Ingress Rule: Minecraft Traffic (Open to everyone)
resource "aws_vpc_security_group_ingress_rule" "minecraft_game" {
  security_group_id = aws_security_group.minecraft_sg.id

  from_port   = 25565
  to_port     = 25565
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  description = "Allow Minecraft players to connect"
}

# 3. Ingress Rule: SSH Access
resource "aws_vpc_security_group_ingress_rule" "minecraft_ssh" {
  security_group_id = aws_security_group.minecraft_sg.id

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = ["0.0.0.0/0"]
  description = "Allow SSH"
}

# 4. Egress Rule: Allow the server to download updates/packages
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.minecraft_sg.id

  ip_protocol = "-1" # semantically equivalent to all ports
  cidr_ipv4   = "0.0.0.0/0"
}