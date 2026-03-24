# General Variables
variable "environment" {
  description = "Environment name (production, staging, development)"
  type        = string
  default     = "production"
}

variable "primary_region" {
  description = "Primary AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "globaltech"
}

# Network Variables
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
}

variable "corporate_cidr_blocks" {
  description = "CIDR blocks for corporate network access"
  type        = list(string)
  default     = ["203.0.113.0/24", "198.51.100.0/24"]
}

# Compute Variables
variable "web_instance_type" {
  description = "Instance type for web servers"
  type        = string
  default     = "t3.large"
}

variable "app_instance_type" {
  description = "Instance type for application servers"
  type        = string
  default     = "r5.xlarge"
}

variable "web_min_size" {
  description = "Minimum number of web servers"
  type        = number
  default     = 3
}

variable "web_max_size" {
  description = "Maximum number of web servers"
  type        = number
  default     = 10
}

variable "web_desired_capacity" {
  description = "Desired number of web servers"
  type        = number
  default     = 5
}

variable "app_min_size" {
  description = "Minimum number of application servers"
  type        = number
  default     = 4
}

variable "app_max_size" {
  description = "Maximum number of application servers"
  type        = number
  default     = 12
}

variable "app_desired_capacity" {
  description = "Desired number of application servers"
  type        = number
  default     = 6
}

# Database Variables
variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.r5.2xlarge"
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS in GB"
  type        = number
  default     = 500
}

variable "db_max_allocated_storage" {
  description = "Maximum allocated storage for RDS autoscaling in GB"
  type        = number
  default     = 1000
}

variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "15.4"
}

variable "db_backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 30
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = true
}

# Storage Variables
variable "s3_lifecycle_glacier_days" {
  description = "Days before transitioning to Glacier"
  type        = number
  default     = 90
}

variable "s3_lifecycle_expiration_days" {
  description = "Days before object expiration"
  type        = number
  default     = 365
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 30
}

# Monitoring Variables
variable "enable_detailed_monitoring" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
  default     = true
}

variable "alert_email" {
  description = "Email address for infrastructure alerts"
  type        = string
  default     = "infrastructure-alerts@globaltech.com"
}

variable "cpu_alarm_threshold" {
  description = "CPU utilization threshold for alarms (%)"
  type        = number
  default     = 80
}

variable "memory_alarm_threshold" {
  description = "Memory utilization threshold for alarms (%)"
  type        = number
  default     = 85
}

variable "disk_alarm_threshold" {
  description = "Disk utilization threshold for alarms (%)"
  type        = number
  default     = 90
}

# Security Variables
variable "enable_encryption" {
  description = "Enable encryption for storage and databases"
  type        = bool
  default     = true
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for critical resources"
  type        = bool
  default     = true
}

variable "ssl_certificate_arn" {
  description = "ARN of SSL certificate for load balancers"
  type        = string
  default     = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
}

# Tags
variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default = {
    Compliance = "SOC2-ISO27001"
    Backup     = "Required"
  }
}

# Auto Scaling Variables
variable "scale_up_cpu_threshold" {
  description = "CPU threshold to trigger scale up"
  type        = number
  default     = 75
}

variable "scale_down_cpu_threshold" {
  description = "CPU threshold to trigger scale down"
  type        = number
  default     = 25
}

variable "scale_up_adjustment" {
  description = "Number of instances to add during scale up"
  type        = number
  default     = 2
}

variable "scale_down_adjustment" {
  description = "Number of instances to remove during scale down"
  type        = number
  default     = 1
}

# Load Balancer Variables
variable "lb_idle_timeout" {
  description = "Load balancer idle timeout in seconds"
  type        = number
  default     = 60
}

variable "lb_deregistration_delay" {
  description = "Target deregistration delay in seconds"
  type        = number
  default     = 30
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of consecutive health checks to be considered healthy"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Number of consecutive health checks to be considered unhealthy"
  type        = number
  default     = 3
}