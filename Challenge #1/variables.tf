################## VPC Module vars #################

variable "tf_vpc_name" {
  description = "Name to be used on all the resources within the VPC module"
  default = "terraform-vpc-test1"
}

variable "tf_cidr" {
  description = "The CIDR block for the VPC"
  default = "10.2.0.0/16"
}

variable "tf_azs" {
  description = "A list of availability zones in the region"
  default = ["eu-west-1a", "eu-west-1b","eu-west-1c"]
}

variable "tf_prvsubnts" {
  description = "A list of private subnets inside the VPC"
  default = ["10.2.10.0/24", "10.2.11.0/24", "10.2.12.0/24"]
}

variable "tf_pubsubnts" {
  description = "A list of public subnets inside the VPC"
  default = ["10.2.1.0/24", "10.2.2.0/24", "]10.2.3.0/24"]
}

variable "tf_dbsubnts" {
  description = "A list of database subnets inside the VPC"
  default = ["10.2.20.0/24", "10.2.21.0/24", "10.2.22.0/24"]
}

variable "tf_vpc_mod_tags" {
  description = "A map of tags to add to all resources created by the VPC module"
  default = {"Terraform" = "true", "Environment" = "terraform-test", "Company" = "My Company", "Service" = "DigitalVault", "User" = "an.other", "CostCenter" = "148_S"}
}

################## EC2 module vars #################

variable "tf_ami_owner" {
  description = "list of AMI owners"
  default = "amazon"
}

variable "tf_ami_name" {
  description = "The name of the AMI"
  default = "Windows_Server-2019-English-Full-Base-2020*"
}

variable "tf_ec2_mod_tags" {
  description = "A map of tags to add to all resources created by the VPC module"
  default = {"Terraform" = "true", "Environment" = "terraform-test", "Company" = "IHSMarkit", "Service" = "DataDictionary", "User" = "jarrod.martin", "CostCenter" = "1480320"}
}

variable "tf_ec2_name" {
  description = "The name of the EC2 instance"
  default = "Terraform_Test-Windows-Server-2019"
}

variable "tf_ec2_instance_type" {
  description = "The instance type"
  default = "t3.small"
}

variable "tf_ec2_key_name" {
  description = "The Key Pair Name used for the instance"
  default = "medm-tech-team"
}

variable "tf_ec2_sql_name" {
  description = "The name of the SQL EC2 instance"
  default = "Terraform_Test-SQL-Server-2019"
}

variable "tf_ec2_sql_instance_type" {
  description = "The instance type"
  default = "t3a.xlarge"
}

################## RDS module vars #################

# Need to parameterise RDS module and place vars here
#variable "tf_rds" {
 # description = "Description"
 # default = "xxxxxxxx"
 #}