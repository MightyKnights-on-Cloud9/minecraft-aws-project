output "vpc_id" {
  description = "The ID of the newly created Minecraft VPC"
  value       = aws_vpc.minecraft_vpc.id
}

output "subnet_id" {
  description = "The ID of the public subnet where the EC2 instance will live"
  value       = aws_subnet.minecraft_subnet.id
}

output "gateway_id" {
  description = "The ID of the internet gateway to the VPC"
  value       = aws_internet_gateway.minecraft_igw.id
}

output "route_table_id" {
  description = "The ID of the route table"
  value       = aws_route_table.public_rt.id
}

output "minecraft_server_public_ip" {
  description = "The public IP address of the Minecraft server to share with players"
  value       = aws_instance.minecraft_server.public_ip
}

output "minecraft_server_public_dns" {
  description = "The AWS-generated public DNS hostname for the server"
  value       = aws_instance.minecraft_server.public_dns
}

output "backup_vault_id" {
  description = "The ARN id of the backup vault storing your server snapshots"
  value       = aws_backup_vault.minecraft_backup_vault.id
}

output "backup_vault_arn" {
  description = "The ARN of the backup vault storing your server snapshots"
  value       = aws_backup_vault.minecraft_backup_vault.arn
}