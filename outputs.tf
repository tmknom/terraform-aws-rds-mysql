output "db_instance_address" {
  value       = aws_db_instance.default.address
  description = "The hostname of the RDS instance. See also endpoint and port."
}

output "db_instance_arn" {
  value       = aws_db_instance.default.arn
  description = "The ARN of the RDS instance."
}

output "db_instance_allocated_storage" {
  value       = aws_db_instance.default.allocated_storage
  description = "The amount of allocated storage."
}

output "db_instance_availability_zone" {
  value       = aws_db_instance.default.availability_zone
  description = "The availability zone of the instance."
}

output "db_instance_backup_retention_period" {
  value       = aws_db_instance.default.backup_retention_period
  description = "The backup retention period."
}

output "db_instance_backup_window" {
  value       = aws_db_instance.default.backup_window
  description = "The backup window."
}

output "db_instance_ca_cert_identifier" {
  value       = aws_db_instance.default.ca_cert_identifier
  description = "Specifies the identifier of the CA certificate for the DB instance."
}

output "db_instance_endpoint" {
  value       = aws_db_instance.default.endpoint
  description = ".The connection endpoint in address:port format."
}

output "db_instance_engine" {
  value       = aws_db_instance.default.engine
  description = "The database engine."
}

output "db_instance_engine_version" {
  value       = aws_db_instance.default.engine_version
  description = "The database engine version."
}

output "db_instance_hosted_zone_id" {
  value       = aws_db_instance.default.hosted_zone_id
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)."
}

output "db_instance_id" {
  value       = aws_db_instance.default.id
  description = "The RDS instance ID."
}

output "db_instance_class" {
  value       = aws_db_instance.default.instance_class
  description = "The RDS instance class."
}

output "db_instance_maintenance_window" {
  value       = aws_db_instance.default.maintenance_window
  description = "The instance maintenance window."
}

output "db_instance_multi_az" {
  value       = aws_db_instance.default.multi_az
  description = "If the RDS instance is multi AZ enabled."
}

output "db_instance_name" {
  value       = aws_db_instance.default.name
  description = "The database name."
}

output "db_instance_port" {
  value       = aws_db_instance.default.port
  description = "The database port."
}

output "db_instance_resource_id" {
  value       = aws_db_instance.default.resource_id
  description = "The RDS Resource ID of this instance."
}

output "db_instance_status" {
  value       = aws_db_instance.default.status
  description = "The RDS instance status."
}

output "db_instance_storage_encrypted" {
  value       = aws_db_instance.default.storage_encrypted
  description = "Specifies whether the DB instance is encrypted."
}

output "db_instance_username" {
  value       = aws_db_instance.default.username
  description = "The master username for the database."
}

output "db_option_group_id" {
  value       = aws_db_option_group.default.id
  description = "The db option group name."
}

output "db_option_group_arn" {
  value       = aws_db_option_group.default.arn
  description = "The ARN of the db option group."
}

output "db_parameter_group_id" {
  value       = aws_db_parameter_group.default.id
  description = "The db parameter group name."
}

output "db_parameter_group_arn" {
  value       = aws_db_parameter_group.default.arn
  description = "The ARN of the db parameter group."
}

output "db_subnet_group_id" {
  value       = aws_db_subnet_group.default.id
  description = "The db subnet group name."
}

output "db_subnet_group_arn" {
  value       = aws_db_subnet_group.default.arn
  description = "The ARN of the db subnet group."
}

output "security_group_id" {
  value       = aws_security_group.default.id
  description = "The ID of the RDS MySQL security group."
}

output "security_group_arn" {
  value       = aws_security_group.default.arn
  description = "The ARN of the RDS MySQL security group."
}

output "security_group_vpc_id" {
  value       = aws_security_group.default.vpc_id
  description = "The VPC ID of the RDS MySQL security group."
}

output "security_group_owner_id" {
  value       = aws_security_group.default.owner_id
  description = "The owner ID of the RDS MySQL security group."
}

output "security_group_name" {
  value       = aws_security_group.default.name
  description = "The name of the RDS MySQL security group."
}

output "security_group_description" {
  value       = aws_security_group.default.description
  description = "The description of the RDS MySQL security group."
}

output "security_group_ingress" {
  value       = aws_security_group.default.ingress
  description = "The ingress rules of the RDS MySQL security group."
}

output "security_group_egress" {
  value       = aws_security_group.default.egress
  description = "The egress rules of the RDS MySQL security group."
}
