resource "aws_iam_role" "minecraft_ec2_role" {
  name = "minecraft-ec2-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "minecraft_policy_attachment" {
  role       = aws_iam_role.minecraft_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_instance_profile" "minecraft_instance_profile" {
  name = "minecraft-ec2-instance-profile"
  role = aws_iam_role.minecraft_ec2_role.name
}

resource "aws_iam_role" "minecraft_backup_role" {
  name = "minecraft-backup-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "minecraft_backup_policy_attachment" {
  role       = aws_iam_role.minecraft_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

# 1. Establish the OpenID Connect Provider connection with GitHub
#resource "aws_iam_openid_connect_provider" "github" {
#  url             = "https://token.actions.githubusercontent.com"
#  client_id_list  = ["sts.amazonaws.com"]
#  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # GitHub's root cert thumbprint
#}

# 2. Build the trust policy restricting access to your specific repository
data "aws_iam_policy_document" "github_allow" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    # LOCKS DOWN THE ROLE: Only your repo can assume this identity
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:MightyKnights-on-Cloud9/minecraft-aws-project:*"]
    }
  }
}

## 3. Create the deployment IAM Role
#resource "aws_iam_role" "github_actions_role" {
#  name               = "github-actions-terraform-executor"
#  assume_role_policy = data.aws_iam_policy_document.github_allow.json
#}

# 4. Output the Role ARN so you can paste it into your GitHub workflow
output "github_actions_role_arn" {
  value = aws_iam_role.github_actions_role.arn
}