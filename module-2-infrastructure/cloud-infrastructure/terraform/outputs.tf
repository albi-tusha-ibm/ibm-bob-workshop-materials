# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "IDs of database subnets"
  value       = aws_subnet.database[*].id
}

output "nat_gateway_ips" {
  description = "Elastic IPs of NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

# Load Balancer Outputs
output "web_alb_dns_name" {
  description = "DNS name of web application load balancer"
  value       = aws_lb.web.dns_name
}

output "web_alb_arn" {
  description = "ARN of web application load balancer"
  value       = aws_lb.web.arn
}

output "web_alb_zone_id" {
  description = "Zone ID of web application load balancer"
  value       = aws_lb.web.zone_id
}

output "app_alb_dns_name" {
  description = "DNS name of application load balancer"
  value       = aws_lb.app.dns_name
}

# Auto Scaling Outputs
output "web_asg_name" {
  description = "Name of web tier auto scaling group"
  value       = aws_autoscaling_group.web.name
}

output "app_asg_name" {
  description = "Name of application tier auto scaling group"
  value       = aws_autoscaling_group.app.name
}

output "web_launch_template_id" {
  description = "ID of web tier launch template"
  value       = aws_launch_template.web.id
}

output "app_launch_template_id" {
  description = "ID of application tier launch template"
  value       = aws_launch_template.app.id
}

# Database Outputs
output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "rds_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.main.id
}

output "rds_arn" {
  description = "ARN of RDS instance"
  value       = aws_db_instance.main.arn
}

output "rds_replica_endpoint" {
  description = "RDS read replica endpoint"
  value       = aws_db_instance.replica.endpoint
  sensitive   = true
}

# Storage Outputs
output "s3_data_bucket_name" {
  description = "Name of S3 data bucket"
  value       = aws_s3_bucket.data.id
}

output "s3_data_bucket_arn" {
  description = "ARN of S3 data bucket"
  value       = aws_s3_bucket.data.arn
}

output "s3_backup_bucket_name" {
  description = "Name of S3 backup bucket"
  value       = aws_s3_bucket.backups.id
}

output "s3_logs_bucket_name" {
  description = "Name of S3 logs bucket"
  value       = aws_s3_bucket.logs.id
}

output "efs_id" {
  description = "ID of EFS file system"
  value       = aws_efs_file_system.shared.id
}

output "efs_dns_name" {
  description = "DNS name of EFS file system"
  value       = aws_efs_file_system.shared.dns_name
}

# Security Group Outputs
output "web_sg_id" {
  description = "ID of web tier security group"
  value       = aws_security_group.web.id
}

output "app_sg_id" {
  description = "ID of application tier security group"
  value       = aws_security_group.app.id
}

output "db_sg_id" {
  description = "ID of database security group"
  value       = aws_security_group.database.id
}

output "bastion_sg_id" {
  description = "ID of bastion security group"
  value       = aws_security_group.bastion.id
}

# IAM Outputs
output "ec2_role_arn" {
  description = "ARN of EC2 instance role"
  value       = aws_iam_role.ec2_instance_role.arn
}

output "ec2_instance_profile_arn" {
  description = "ARN of EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.arn
}

# Monitoring Outputs
output "cloudwatch_log_group_name" {
  description = "Name of CloudWatch log group"
  value       = aws_cloudwatch_log_group.infrastructure.name
}

output "sns_topic_arn" {
  description = "ARN of SNS topic for alerts"
  value       = aws_sns_topic.infrastructure_alerts.arn
}

# Encryption Outputs
output "kms_key_id" {
  description = "ID of KMS key for encryption"
  value       = aws_kms_key.infrastructure.id
}

output "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  value       = aws_kms_key.infrastructure.arn
}

# Route53 Outputs
output "route53_zone_id" {
  description = "ID of Route53 hosted zone"
  value       = aws_route53_zone.main.zone_id
}

output "route53_name_servers" {
  description = "Name servers for Route53 zone"
  value       = aws_route53_zone.main.name_servers
}

# CloudFront Outputs
output "cloudfront_distribution_id" {
  description = "ID of CloudFront distribution"
  value       = aws_cloudfront_distribution.main.id
}

output "cloudfront_domain_name" {
  description = "Domain name of CloudFront distribution"
  value       = aws_cloudfront_distribution.main.domain_name
}

# Backup Outputs
output "backup_vault_arn" {
  description = "ARN of AWS Backup vault"
  value       = aws_backup_vault.main.arn
}

output "backup_plan_id" {
  description = "ID of AWS Backup plan"
  value       = aws_backup_plan.main.id
}

# Summary Output
output "infrastructure_summary" {
  description = "Summary of deployed infrastructure"
  value = {
    environment           = var.environment
    region               = var.primary_region
    vpc_id               = aws_vpc.main.id
    web_instances        = "${var.web_min_size}-${var.web_max_size}"
    app_instances        = "${var.app_min_size}-${var.app_max_size}"
    database_engine      = "PostgreSQL ${var.db_engine_version}"
    encryption_enabled   = var.enable_encryption
    multi_az_enabled     = var.db_multi_az
    backup_retention     = "${var.backup_retention_days} days"
  }
}