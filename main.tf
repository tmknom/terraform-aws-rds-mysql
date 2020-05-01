# Terraform module which creates MySQL RDS resources on AWS.
#
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html

# Changes to a DB instance can occur when you manually change a parameter, such as allocated_storage,
# and are reflected in the next maintenance window. Because of this, Terraform may report a difference
# in its planning phase because a modification has not yet taken place. You can use the apply_immediately flag
# to instruct the service to apply the change immediately.
#
# https://www.terraform.io/docs/providers/aws/r/db_instance.html
resource "aws_db_instance" "default" {
  engine                 = "mysql"
  option_group_name      = aws_db_option_group.default.name
  parameter_group_name   = aws_db_parameter_group.default.name
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.default.id]

  # The DB instance identifier. This parameter is stored as a lowercase string.
  #
  # - Must contain from 1 to 63 letters, numbers, or hyphens.
  # - First character must be a letter
  # - Cannot end with a hyphen or contain two consecutive hyphens.
  # - Must be unique for all DB instances per AWS account, per region.
  #
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html#RDS_Limits.Constraints
  identifier = var.identifier

  # For MySQL, version numbers are organized as version = X.Y.Z. In Amazon RDS terminology,
  # X.Y denotes the major version, and Z is the minor version number.
  #
  # If no version is specified, Amazon RDS will default to a supported version, typically the most recent version.
  # If a major version (for example, MySQL 5.7) is specified but a minor version is not,
  # Amazon RDS will default to a recent release of the major version you have specified.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine_version = var.engine_version

  # The DB instance class determines the computation and memory capacity of an Amazon RDS DB instance.
  # We recommend only using db.t2 instance classes for development and test servers, or other non-production servers.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
  instance_class = var.instance_class

  # Allocable range of storage:
  #
  # - General Purpose SSD Storage - 20 GiB–32 TiB
  # - Provisioned IOPS SSD Storage - 100 GiB–32 TiB
  #
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html
  allocated_storage = var.allocated_storage

  # The name for the master user.
  #
  # - Must be 1 to 16 letters or numbers.
  # - First character must be a letter.
  # - Can't be a reserved word for the chosen database engine.
  #
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html#RDS_Limits.Constraints
  username = var.username

  # The password for the master user.
  #
  # - Can include any printable ASCII character except "/", """, or "@".
  # - Must contain from 8 to 41 characters.
  #
  # NOTE: password may show up in logs, and it will be stored in the raw state as plain-text.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html#RDS_Limits.Constraints
  password = var.password

  # Every DB instance has a weekly maintenance window during which any system changes are applied.
  # Most maintenance events also complete during the 30-minute maintenance window,
  # although larger maintenance events may take more than 30 minutes to complete.
  # The maintenance window should fall at the time of lowest usage and thus might need modification from time to time.
  #
  # - Must be in the format ddd:hh24:mi-ddd:hh24:mi. (Example: "Mon:00:00-Mon:03:00")
  # - Must be in Universal Coordinated Time (UTC).
  # - Must not conflict with the preferred backup window.
  # - Must be at least 30 minutes.
  #
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#Concepts.DBMaintenance
  maintenance_window = var.maintenance_window

  # Automated backups occur daily during the preferred backup window.
  # If the backup requires more time than allotted to the backup window, the backup continues after the window ends, until it finishes.
  #
  # - Must be in the format hh24:mi-hh24:mi. (Example: "09:46-10:16")
  # - Must be in Universal Coordinated Time (UTC).
  # - Must not conflict with the preferred maintenance window.
  # - Must be at least 30 minutes.
  #
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow
  backup_window = var.backup_window

  # When you modify a DB instance, you can apply the changes immediately.
  # If any of the pending modifications require downtime, choosing apply immediately can cause unexpected downtime.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.Modifying.html#USER_ModifyInstance.ApplyImmediately
  apply_immediately = var.apply_immediately

  # Amazon RDS provides high availability and failover support for DB instances using Multi-AZ deployments.
  # In a Multi-AZ deployment, Amazon RDS automatically provisions
  # and maintains a synchronous standby replica in a different Availability Zone.
  #
  # In the event of a planned or unplanned outage of your DB instance, Amazon RDS automatically switches to
  # a standby replica in another Availability Zone if you have enabled Multi-AZ. Failover times are typically 60-120 seconds.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html
  multi_az = var.multi_az

  # The port that you want to access the DB instance through.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CreateInstance.html
  port = var.port

  # The name of the database. If this parameter is not specified, no database is created in the DB instance.
  #
  # - Must contain 1 to 64 letters or numbers.
  # - Can't be a word reserved by the specified database engine
  #
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html#RDS_Limits.Constraints
  name = var.name

  # The following list briefly describes the three storage types:
  #
  # - General Purpose SSD – Also known as gp2, volumes offer cost-effective storage that is ideal for a broad range of workloads.
  # - Provisioned IOPS – Also known as io1, that require low I/O latency and consistent I/O throughput.
  # - Magnetic – RDS also supports magnetic storage for backward compatibility.
  #
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html
  storage_type = var.storage_type

  # The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for the DB instance.
  # Must be a multiple between 1 and 50 of the storage amount, and range of Provisioned IOPS is 1000–32,000
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS
  iops = var.iops

  # You can enable auto minor version upgrades for the database.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Upgrading.html#USER_UpgradeDBInstance.Upgrading.AutoMinorVersionUpgrades
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  # When upgrading the major version of an engine, allow_major_version_upgrade must be set to true.
  # https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_ModifyDBInstance.html
  allow_major_version_upgrade = var.allow_major_version_upgrade

  # You can set the backup retention period to between 0 and 35 days.
  # Setting the backup retention period to 0 disables automated backups.
  # Manual snapshot limits (100 per region) do not apply to automated backups.
  # An outage occurs if you change the backup retention period from 0 to a non-zero value or from a non-zero value to 0.
  # We highly discourage disabling automated backups because it disables point-in-time recovery.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupRetention
  #
  # When creating a Read Replica, you must enable automatic backups on the source DB instance by setting this value other than 0.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReadRepl.html#USER_ReadRepl.Create
  backup_retention_period = var.backup_retention_period

  # For an Amazon RDS encrypted DB instance, all logs, backups, and snapshots are encrypted.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Encryption.html#Overview.Encryption.Enabling
  storage_encrypted = var.storage_encrypted

  # You can supply the AWS KMS key identifier for your encryption key.
  # If you don't specify an AWS KMS key identifier, then Amazon RDS uses your default encryption key.
  #
  # NOTE: You can't share a snapshot that has been encrypted using the default AWS KMS encryption key
  #       of the AWS account that shared the snapshot.
  #
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Encryption.html
  kms_key_id = var.kms_key_id

  # You can only delete instances that don't have deletion protection enabled.
  # To delete a DB instance that has deletion protection enabled, first modify the instance and disable deletion protection.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html
  deletion_protection = var.deletion_protection

  # When you delete a DB instance, you can create a final snapshot of the DB instance.
  # If omitted, no final snapshot will be made.
  #
  # - Must be 1 to 255 letters or numbers.
  # - First character must be a letter.
  # - Can't end with a hyphen or contain two consecutive hyphens.
  # - Can't be specified when deleting a Read Replica.
  #
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html#USER_DeleteInstance.Snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  # A value that indicates whether a final DB snapshot is created before the DB instance is deleted.
  # If true is specified, no DB snapshot is created.
  # If false is specified, a DB snapshot is created before the DB instance is deleted.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html#USER_DeleteInstance.Snapshot
  skip_final_snapshot = var.skip_final_snapshot

  # Specifies whether or not to create this database from a snapshot. 
  # This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05.
  snapshot_identifier = var.snapshot_identifier

  # You can configure your Amazon RDS MySQL DB instance to publish log data to a log group in Amazon CloudWatch Logs.
  # Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace.
  # If omitted, no logs will be exported.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.Concepts.MySQL.html#USER_LogAccess.MySQLDB.PublishtoCloudWatchLogs
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  # A smaller monitoring interval results in more frequent reporting of OS metrics and increases your monitoring cost.
  # You can be set to one of the following values: 1, 5, 10, 15, 30, or 60.
  # To disable collecting Enhanced Monitoring metrics, specify 0.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html
  monitoring_interval = var.monitoring_interval

  # Enhanced Monitoring requires permission to act on your behalf to send OS metric information to CloudWatch Logs.
  # You grant Enhanced Monitoring the required permissions using an IAM role.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html#USER_Monitoring.OS.Enabling
  monitoring_role_arn = var.monitoring_role_arn

  # You can authenticate to your DB instance using IAM database authentication.
  # With this authentication method, you don't need to use a password when you connect to a DB instance.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  # You can specify that the tags from the DB instance are copied to snapshots of the DB instance.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html#USER_Tagging.CopyTags
  copy_tags_to_snapshot = var.copy_tags_to_snapshot

  # This parameter lets you designate whether there is public access to the DB instance.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Hiding
  publicly_accessible = var.publicly_accessible

  # This parameter lets you designate CA to be used on instance
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL-certificate-rotation.html
  ca_cert_identifier = var.ca_cert_identifier

  # License model information for this DB instance.
  # MySQL has only one license model, general-public-license the general license agreement for MySQL.
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CreateInstance.html
  license_model = var.license_model

  # A mapping of tags to assign to the resource.
  tags = merge({ "Name" = var.identifier }, var.tags)

  # The password defined in Terraform is an initial value, it must be changed after creating the RDS instance.
  # Therefore, suppress plan diff after changing the password.
  lifecycle {
    ignore_changes = [password]
  }
}

# NOTE: Any modifications to the db_option_group are set to happen immediately as we default to applying immediately.
#
# https://www.terraform.io/docs/providers/aws/r/db_option_group.html
resource "aws_db_option_group" "default" {
  engine_name              = "mysql"
  name                     = var.identifier
  major_engine_version     = local.major_engine_version
  option_group_description = var.description

  tags = merge({ "Name" = var.identifier }, var.tags)
}

# If major_engine_version is unspecified, then calculate major_engine_version.
# Calculate from X.Y.Z(or X.Y) to X.Y, for example 5.7.21 is calculated 5.7.
locals {
  version_elements       = split(".", var.engine_version)
  major_version_elements = [local.version_elements[0], local.version_elements[1]]
  major_engine_version   = var.major_engine_version == "" ? join(".", local.major_version_elements) : var.major_engine_version
}

# https://www.terraform.io/docs/providers/aws/r/db_parameter_group.html
resource "aws_db_parameter_group" "default" {
  name        = var.identifier
  family      = local.family
  description = var.description

  parameter {
    name         = "character_set_client"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_connection"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_database"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_results"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_server"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "collation_connection"
    value        = var.collation
    apply_method = "immediate"
  }

  parameter {
    name         = "collation_server"
    value        = var.collation
    apply_method = "immediate"
  }

  parameter {
    name         = "time_zone"
    value        = var.time_zone
    apply_method = "immediate"
  }

  parameter {
    name         = "tx_isolation"
    value        = var.tx_isolation
    apply_method = "immediate"
  }

  tags = merge({ "Name" = var.identifier }, var.tags)
}

locals {
  family = "mysql${local.major_engine_version}"
}

# https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html
resource "aws_db_subnet_group" "default" {
  name        = var.identifier
  subnet_ids  = var.subnet_ids
  description = var.description

  tags = merge({ "Name" = var.identifier }, var.tags)
}

# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "default" {
  name   = local.security_group_name
  vpc_id = var.vpc_id

  tags = merge({ "Name" = local.security_group_name }, var.tags)
}

locals {
  security_group_name = "${var.identifier}-rds-mysql"
}

# https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.source_cidr_blocks
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}
