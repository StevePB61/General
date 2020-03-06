output "VPC-ID" {
    value = "${module.vpc.vpc_id}"
}

output "prv_sub_ids" {
    value = "${module.vpc.private_subnets}"
}

output "rdp_sec_gp_id" {
    value = "${module.security-group.this_security_group_id}"
}

output "ec2-instance-id" {
    value = "${module.ec2-instance.id}"
}