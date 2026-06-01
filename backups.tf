# 1. Create a Vault to store the backups
resource "aws_backup_vault" "minecraft_backup_vault" {
  name = "minecraft-backup-vault"
}

# 2. Define the Backup Plan (Schedule)
resource "aws_backup_plan" "minecraft_backup_plan" {
  name = "minecraft-daily-backup"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.minecraft_backup_vault.name
    schedule          = "cron(0 2 * * ? *)" # Daily at 2:00 AM UTC

    lifecycle {
      delete_after = 7 # Keep backups for 7 days
    }
  }
}

# 3. Connect the Plan to your EC2 Instance
resource "aws_backup_selection" "minecraft_backup_selection" {
  iam_role_arn = aws_iam_role.minecraft_backup_role.arn
  name         = "minecraft-backup-selection"
  plan_id      = aws_backup_plan.minecraft_backup_plan.id

  resources = [
    aws_instance.minecraft_server.arn
  ]
}
