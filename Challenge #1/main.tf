provider "aws" {
  region  = "eu-west-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.24.0"

  name = var.tf_vpc_name
  cidr = var.tf_cidr
  azs             = var.tf_azs
  private_subnets = var.tf_prvsubnts
  public_subnets  = var.tf_pubsubnts
  database_subnets = var.tf_dbsubnts
  enable_nat_gateway = true
  tags = var.tf_vpc_mod_tags
}

module "vpc-flow-logs" {
  source  = "umotif-public/vpc-flow-logs/aws"
  version = "1.0.1"

  vpc_id = "${module.vpc.vpc_id}"
  name_prefix = var.tf_vpc_name
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.4.0"

  name   = "Test Security Group"
  vpc_id = "${module.vpc.vpc_id}"
}

module "rds" {
source  = "terraform-aws-modules/rds/aws"
  version = "2.14.0"

  identifier = "demodb"

  engine            = "sqlserver-ex"
  engine_version    = "14.00.1000.169.v1"
  instance_class    = "db.t2.medium"
  allocated_storage = 20
  storage_encrypted = false

  name     = null # "demodb"
  username = "demouser"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "1433"

  subnet_ids = var.tf_dbsubnts
  vpc_security_group_ids = [module.security-group.this_security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = var.tf_vpc_mod_tags

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "demodb"
}

data "aws_ami" "aws_ec2_ami" {
  most_recent = true
  owners = [var.tf_ami_owner]

  filter {
    name   = "name"
    values = [var.tf_ami_name]
    }
  }

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name = var.tf_ec2_name
  ami = "${data.aws_ami.aws_ec2_ami.id}"
  instance_type = var.tf_ec2_instance_type
  instance_count = "2"
  key_name = var.tf_ec2_key_name
  vpc_security_group_ids = [module.security-group.this_security_group_id]
  subnet_id = module.vpc.private_subnets[0]
  tags = var.tf_ec2_mod_tags
}