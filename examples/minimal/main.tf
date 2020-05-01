module "rds_mysql" {
  source            = "../../"
  identifier        = "example"
  engine_version    = "5.7.28"
  instance_class    = "db.t2.small"
  allocated_storage = 20
  username          = "root"
  password          = "YouShouldChangePasswordAfterApply!"

  subnet_ids          = module.vpc.public_subnet_ids
  vpc_id              = module.vpc.vpc_id
  source_cidr_blocks = [module.vpc.vpc_cidr_block]
}

module "vpc" {
  source                    = "git::https://github.com/tmknom/terraform-aws-vpc.git?ref=tags/2.0.1"
  cidr_block                = local.cidr_block
  name                      = "vpc-rds-mysql"
  public_subnet_cidr_blocks = [cidrsubnet(local.cidr_block, 8, 0), cidrsubnet(local.cidr_block, 8, 1)]
  public_availability_zones = data.aws_availability_zones.available.names
}

locals {
  cidr_block = "10.255.0.0/16"
}

data "aws_availability_zones" "available" {}
