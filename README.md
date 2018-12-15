# terraform-aws-rds-mysql

[![CircleCI](https://circleci.com/gh/tmknom/terraform-aws-rds-mysql.svg?style=svg)](https://circleci.com/gh/tmknom/terraform-aws-rds-mysql)
[![GitHub tag](https://img.shields.io/github/tag/tmknom/terraform-aws-rds-mysql.svg)](https://registry.terraform.io/modules/tmknom/rds-mysql/aws)
[![License](https://img.shields.io/github/license/tmknom/terraform-aws-rds-mysql.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module which creates MySQL RDS resources on AWS.

## Description

Provision [RDS DB Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.html),
[Option Group](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithOptionGroups.html) and
[Parameter Group](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html).

This module provides recommended settings:

- Enable deletion protection
- Enable Multi-AZ
- Enable encryption
- Enable IAM database authentication
- Enable automated backups
- Sufficient backup retention period
- Disable publicly accessible

## Usage

### Minimal

```hcl
module "rds_mysql" {
  source            = "git::https://github.com/tmknom/terraform-aws-rds-mysql.git?ref=tags/1.1.0"
  identifier        = "example"
  engine_version    = "5.7.23"
  instance_class    = "db.t2.small"
  allocated_storage = 20
  username          = "root"
  password          = "YouShouldChangePasswordAfterApply!"

  subnet_ids          = ["${var.subnets}"]
  vpc_id              = "${var.vpc_id}"
  ingress_cidr_blocks = ["${var.ingress_cidr_blocks}"]
}
```

### Complete

```hcl
module "rds_mysql" {
  source            = "git::https://github.com/tmknom/terraform-aws-rds-mysql.git?ref=tags/1.1.0"
  identifier        = "example"
  engine_version    = "5.7.23"
  instance_class    = "db.t2.small"
  allocated_storage = 20
  username          = "root"
  password          = "YouShouldChangePasswordAfterApply!"

  subnet_ids          = ["${var.subnets}"]
  vpc_id              = "${var.vpc_id}"
  ingress_cidr_blocks = ["${var.ingress_cidr_blocks}"]

  maintenance_window                  = "mon:10:10-mon:10:40"
  backup_window                       = "09:10-09:40"
  apply_immediately                   = false
  multi_az                            = false
  port                                = 3306
  name                                = "example"
  storage_type                        = "gp2"
  iops                                = 0
  auto_minor_version_upgrade          = false
  allow_major_version_upgrade         = false
  backup_retention_period             = 0
  storage_encrypted                   = false
  kms_key_id                          = ""
  deletion_protection                 = false
  final_snapshot_identifier           = "final-snapshot"
  skip_final_snapshot                 = true
  enabled_cloudwatch_logs_exports     = []
  monitoring_interval                 = 0
  monitoring_role_arn                 = ""
  iam_database_authentication_enabled = false
  copy_tags_to_snapshot               = false
  publicly_accessible                 = true
  license_model                       = "general-public-license"
  major_engine_version                = "5.7"
  description                         = "This is example"

  tags = {
    Environment = "prod"
  }
}
```

## Examples

- [Minimal](https://github.com/tmknom/terraform-aws-rds-mysql/tree/master/examples/minimal)
- [Complete](https://github.com/tmknom/terraform-aws-rds-mysql/tree/master/examples/complete)

## Inputs

| Name                                | Description                                                                                                           |  Type  |         Default          | Required |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------------------- | :----: | :----------------------: | :------: |
| allocated_storage                   | The allocated storage in gibibytes.                                                                                   | string |            -             |   yes    |
| engine_version                      | The engine version to use.                                                                                            | string |            -             |   yes    |
| identifier                          | The name of the RDS instance.                                                                                         | string |            -             |   yes    |
| ingress_cidr_blocks                 | List of Ingress CIDR blocks.                                                                                          |  list  |            -             |   yes    |
| instance_class                      | The instance type of the RDS instance.                                                                                | string |            -             |   yes    |
| password                            | Password for the master DB user.                                                                                      | string |            -             |   yes    |
| subnet_ids                          | A list of VPC subnet IDs.                                                                                             |  list  |            -             |   yes    |
| username                            | Username for the master DB user.                                                                                      | string |            -             |   yes    |
| vpc_id                              | VPC Id to associate with RDS MySQL.                                                                                   | string |            -             |   yes    |
| allow_major_version_upgrade         | Indicates that major version upgrades are allowed.                                                                    | string |          `true`          |    no    |
| apply_immediately                   | Specifies whether any database modifications are applied immediately, or during the next maintenance window.          | string |         `false`          |    no    |
| auto_minor_version_upgrade          | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window.. | string |          `true`          |    no    |
| backup_retention_period             | The days to retain backups for. Must be between 0 and 35.                                                             | string |           `30`           |    no    |
| backup_window                       | The daily time range (in UTC) during which automated backups are created if they are enabled.                         | string |         `` | no          |
| character_set                       | The database character set.                                                                                           | string |        `utf8mb4`         |    no    |
| collation                           | The database collation.                                                                                               | string |      `utf8mb4_bin`       |    no    |
| copy_tags_to_snapshot               | On delete, copy all Instance tags to the final snapshot.                                                              | string |          `true`          |    no    |
| deletion_protection                 | If the DB instance should have deletion protection enabled.                                                           | string |          `true`          |    no    |
| description                         | The description of the all resources.                                                                                 | string |  `Managed by Terraform`  |    no    |
| enabled_cloudwatch_logs_exports     | List of log types to enable for exporting to CloudWatch logs.                                                         |  list  |           `[]`           |    no    |
| final_snapshot_identifier           | The name of your final DB snapshot when this DB instance is deleted.                                                  | string |     `final-snapshot`     |    no    |
| iam_database_authentication_enabled | Specifies whether or mappings of IAM accounts to database accounts is enabled.                                        | string |          `true`          |    no    |
| iops                                | The amount of provisioned IOPS. Setting this implies a storage_type of io1.                                           | string |           `0`            |    no    |
| kms_key_id                          | The ARN for the KMS encryption key.                                                                                   | string |         `` | no          |
| license_model                       | License model information for this DB instance.                                                                       | string | `general-public-license` |    no    |
| maintenance_window                  | The window to perform maintenance in.                                                                                 | string |         `` | no          |
| major_engine_version                | Specifies the major version of the engine that this option group should be associated with.                           | string |         `` | no          |
| monitoring_interval                 | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.          | string |           `0`            |    no    |
| monitoring_role_arn                 | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs.                     | string |         `` | no          |
| multi_az                            | Specifies if the RDS instance is multi-AZ.                                                                            | string |          `true`          |    no    |
| name                                | The name of the database to create when the DB instance is created.                                                   | string |         `` | no          |
| port                                | The port on which the DB accepts connections.                                                                         | string |          `3306`          |    no    |
| publicly_accessible                 | Bool to control if instance is publicly accessible.                                                                   | string |         `false`          |    no    |
| skip_final_snapshot                 | Determines whether a final DB snapshot is created before the DB instance is deleted.                                  | string |         `false`          |    no    |
| storage_encrypted                   | Specifies whether the DB instance is encrypted.                                                                       | string |          `true`          |    no    |
| storage_type                        | One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD).                                 | string |          `gp2`           |    no    |
| tags                                | A mapping of tags to assign to all resources.                                                                         |  map   |           `{}`           |    no    |
| time_zone                           | The database time zone.                                                                                               | string |          `UTC`           |    no    |
| tx_isolation                        | Sets the default transaction isolation level.                                                                         | string |    `REPEATABLE-READ`     |    no    |

## Outputs

| Name                                | Description                                                                              |
| ----------------------------------- | ---------------------------------------------------------------------------------------- |
| db_instance_address                 | The hostname of the RDS instance. See also endpoint and port.                            |
| db_instance_allocated_storage       | The amount of allocated storage.                                                         |
| db_instance_arn                     | The ARN of the RDS instance.                                                             |
| db_instance_availability_zone       | The availability zone of the instance.                                                   |
| db_instance_backup_retention_period | The backup retention period.                                                             |
| db_instance_backup_window           | The backup window.                                                                       |
| db_instance_ca_cert_identifier      | Specifies the identifier of the CA certificate for the DB instance.                      |
| db_instance_class                   | The RDS instance class.                                                                  |
| db_instance_endpoint                | .The connection endpoint in address:port format.                                         |
| db_instance_engine                  | The database engine.                                                                     |
| db_instance_engine_version          | The database engine version.                                                             |
| db_instance_hosted_zone_id          | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record). |
| db_instance_id                      | The RDS instance ID.                                                                     |
| db_instance_maintenance_window      | The instance maintenance window.                                                         |
| db_instance_multi_az                | If the RDS instance is multi AZ enabled.                                                 |
| db_instance_name                    | The database name.                                                                       |
| db_instance_port                    | The database port.                                                                       |
| db_instance_resource_id             | The RDS Resource ID of this instance.                                                    |
| db_instance_status                  | The RDS instance status.                                                                 |
| db_instance_storage_encrypted       | Specifies whether the DB instance is encrypted.                                          |
| db_instance_username                | The master username for the database.                                                    |
| db_option_group_arn                 | The ARN of the db option group.                                                          |
| db_option_group_id                  | The db option group name.                                                                |
| db_parameter_group_arn              | The ARN of the db parameter group.                                                       |
| db_parameter_group_id               | The db parameter group name.                                                             |
| db_subnet_group_arn                 | The ARN of the db subnet group.                                                          |
| db_subnet_group_id                  | The db subnet group name.                                                                |
| security_group_arn                  | The ARN of the RDS MySQL security group.                                                 |
| security_group_description          | The description of the RDS MySQL security group.                                         |
| security_group_egress               | The egress rules of the RDS MySQL security group.                                        |
| security_group_id                   | The ID of the RDS MySQL security group.                                                  |
| security_group_ingress              | The ingress rules of the RDS MySQL security group.                                       |
| security_group_name                 | The name of the RDS MySQL security group.                                                |
| security_group_owner_id             | The owner ID of the RDS MySQL security group.                                            |
| security_group_vpc_id               | The VPC ID of the RDS MySQL security group.                                              |

## Development

### Requirements

- [Docker](https://www.docker.com/)

### Configure environment variables

```shell
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=ap-northeast-1
```

### Installation

```shell
git clone git@github.com:tmknom/terraform-aws-rds-mysql.git
cd terraform-aws-rds-mysql
make install
```

### Makefile targets

```text
check-format                   Check format code
cibuild                        Execute CI build
clean                          Clean .terraform
docs                           Generate docs
format                         Format code
help                           Show help
install                        Install requirements
lint                           Lint code
release                        Release GitHub and Terraform Module Registry
terraform-apply-complete       Run terraform apply examples/complete
terraform-apply-minimal        Run terraform apply examples/minimal
terraform-destroy-complete     Run terraform destroy examples/complete
terraform-destroy-minimal      Run terraform destroy examples/minimal
terraform-plan-complete        Run terraform plan examples/complete
terraform-plan-minimal         Run terraform plan examples/minimal
upgrade                        Upgrade makefile
```

### Releasing new versions

Bump VERSION file, and run `make release`.

### Terraform Module Registry

- <https://registry.terraform.io/modules/tmknom/rds-mysql/aws>

## License

Apache 2 Licensed. See LICENSE for full details.
