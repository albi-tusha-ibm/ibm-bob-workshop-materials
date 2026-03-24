terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket         = "globaltech-terraform-state"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = var.primary_region
  
  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "GlobalTech-Infrastructure"
      CostCenter  = "Infrastructure"
      Owner       = "infrastructure-team@globaltech.com"
    }
  }
}

provider "aws" {
  alias  = "us_west"
  region = "us-west-2"
  
  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "GlobalTech-Infrastructure"
      CostCenter  = "Infrastructure"
    }
  }
}

provider "aws" {
  alias  = "eu_west"
  region = "eu-west-1"
  
  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "GlobalTech-Infrastructure"
      CostCenter  = "Infrastructure"
    }
  }
}

provider "aws" {
  alias  = "ap_southeast"
  region = "ap-southeast-1"
  
  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "GlobalTech-Infrastructure"
      CostCenter  = "Infrastructure"
    }
  }
}

# Data sources for existing resources
data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

# KMS key for encryption
resource "aws_kms_key" "infrastructure" {
  description             = "KMS key for infrastructure encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  
  tags = {
    Name = "${var.environment}-infrastructure-key"
  }
}

resource "aws_kms_alias" "infrastructure" {
  name          = "alias/${var.environment}-infrastructure"
  target_key_id = aws_kms_key.infrastructure.key_id
}

# SNS topic for alerts
resource "aws_sns_topic" "infrastructure_alerts" {
  name              = "${var.environment}-infrastructure-alerts"
  kms_master_key_id = aws_kms_key.infrastructure.id
  
  tags = {
    Name = "${var.environment}-infrastructure-alerts"
  }
}

resource "aws_sns_topic_subscription" "infrastructure_alerts_email" {
  topic_arn = aws_sns_topic.infrastructure_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# CloudWatch Log Group for centralized logging
resource "aws_cloudwatch_log_group" "infrastructure" {
  name              = "/aws/infrastructure/${var.environment}"
  retention_in_days = 90
  kms_key_id        = aws_kms_key.infrastructure.arn
  
  tags = {
    Name = "${var.environment}-infrastructure-logs"
  }
}

# IAM role for EC2 instances
resource "aws_iam_role" "ec2_instance_role" {
  name = "${var.environment}-ec2-instance-role"
  
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
  
  tags = {
    Name = "${var.environment}-ec2-instance-role"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatch" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}-ec2-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}

# Security group for SSH access (restricted)
resource "aws_security_group" "bastion" {
  name        = "${var.environment}-bastion-sg"
  description = "Security group for bastion hosts"
  vpc_id      = aws_vpc.main.id
  
  ingress {
    description = "SSH from corporate network"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.corporate_cidr_blocks
  }
  
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.environment}-bastion-sg"
  }
}

# Outputs
output "account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "kms_key_id" {
  description = "KMS key ID for infrastructure encryption"
  value       = aws_kms_key.infrastructure.id
}

output "sns_topic_arn" {
  description = "SNS topic ARN for infrastructure alerts"
  value       = aws_sns_topic.infrastructure_alerts.arn
}

output "ec2_instance_profile_name" {
  description = "EC2 instance profile name"
  value       = aws_iam_instance_profile.ec2_profile.name
}