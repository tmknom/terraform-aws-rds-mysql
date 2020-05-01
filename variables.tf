variable "identifier" {
  type        = string
  description = " The name of the RDS instance."
}

variable "engine_version" {
  type        = string
  description = "The engine version to use."
}

variable "instance_class" {
  type        = string
  description = "The instance type of the RDS instance."
}

variable "allocated_storage" {
  type        = string
  description = "The allocated storage in gibibytes."
}

variable "username" {
  type        = string
  description = "Username for the master DB user."
}

variable "password" {
  type        = string
  description = "Password for the master DB user."
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of VPC subnet IDs."
}

variable "vpc_id" {
  type        = string
  description = "VPC Id to associate with RDS MySQL."
}

variable "source_cidr_blocks" {
  type        = list(string)
  description = "List of source CIDR blocks."
}

variable "maintenance_window" {
  default     = ""
  type        = string
  description = "The window to perform maintenance in."
}

variable "backup_window" {
  default     = ""
  type        = string
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled."
}

variable "apply_immediately" {
  default     = false
  type        = string
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
}

variable "multi_az" {
  default     = true
  type        = string
  description = "Specifies if the RDS instance is multi-AZ."
}

variable "port" {
  default     = 3306
  type        = string
  description = "The port on which the DB accepts connections."
}

variable "name" {
  default     = ""
  type        = string
  description = "The name of the database to create when the DB instance is created."
}

variable "storage_type" {
  default     = "gp2"
  type        = string
  description = "One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD)."
}

variable "iops" {
  default     = 0
  type        = string
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of io1."
}

variable "auto_minor_version_upgrade" {
  default     = true
  type        = string
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window.."
}

variable "allow_major_version_upgrade" {
  default     = true
  type        = string
  description = "Indicates that major version upgrades are allowed."
}

variable "backup_retention_period" {
  default     = "30"
  type        = string
  description = "The days to retain backups for. Must be between 0 and 35."
}

variable "storage_encrypted" {
  default     = true
  type        = string
  description = "Specifies whether the DB instance is encrypted."
}

variable "kms_key_id" {
  default     = ""
  type        = string
  description = "The ARN for the KMS encryption key."
}

variable "deletion_protection" {
  default     = true
  type        = string
  description = "If the DB instance should have deletion protection enabled."
}

variable "final_snapshot_identifier" {
  default     = "final-snapshot"
  type        = string
  description = "The name of your final DB snapshot when this DB instance is deleted."
}

variable "snapshot_identifier" {
  default     = ""
  type        = string
  description = "The DB snapshot used when DB instance is created."
}
variable "skip_final_snapshot" {
  default     = false
  type        = string
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
}

variable "enabled_cloudwatch_logs_exports" {
  default     = []
  type        = list(string)
  description = "List of log types to enable for exporting to CloudWatch logs."
}

variable "monitoring_interval" {
  default     = 0
  type        = string
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
}

variable "monitoring_role_arn" {
  default     = ""
  type        = string
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
}

variable "iam_database_authentication_enabled" {
  default     = true
  type        = string
  description = "Specifies whether or mappings of IAM accounts to database accounts is enabled."
}

variable "copy_tags_to_snapshot" {
  default     = true
  type        = string
  description = "On delete, copy all Instance tags to the final snapshot."
}

variable "publicly_accessible" {
  default     = false
  type        = string
  description = "Bool to control if instance is publicly accessible."
}

variable "license_model" {
  default     = "general-public-license"
  type        = string
  description = "License model information for this DB instance."
}

variable "major_engine_version" {
  default     = ""
  type        = string
  description = "Specifies the major version of the engine that this option group should be associated with."
}

variable "description" {
  default     = "Managed by Terraform"
  type        = string
  description = "The description of the all resources."
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "A mapping of tags to assign to all resources."
}

variable "character_set" {
  default     = "utf8mb4"
  type        = string
  description = "The database character set."
}

variable "collation" {
  default     = "utf8mb4_bin"
  type        = string
  description = "The database collation."
}

variable "time_zone" {
  default     = "UTC"
  type        = string
  description = "The database time zone."
}

variable "tx_isolation" {
  default     = "REPEATABLE-READ"
  type        = string
  description = "Sets the default transaction isolation level."
}

variable "ca_cert_identifier" {
  default     = "rds-ca-2019"
  type        = string
  description = "The identifier of the CA certificate for the DB instance."
}
