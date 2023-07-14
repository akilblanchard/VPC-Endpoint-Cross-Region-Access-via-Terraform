
#VPC Declarations

module "vpc_us_east_1" {
    source = "terraform-aws-modules/vpc/aws"
    version = "3.10.0"
    name = local.vpc.us-east-1.name
    cidr = local.vpcs.us-vpc_us_east_1.cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    azs = local.vpcs.us-east-1.azs
    private_subnets = local.vpcs.us-east-1.private_subnets
    tags = local.common_tags
}

module "vpc_us_east_2" {
    source = "terraform-aws-modules/vpc/aws"
    version = "3.10.0"
    name = local.vpc.us-east-2.name
    cidr = local.vpcs.us-vpc_us_east_2.cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    azs = local.vpcs.us-east-2.azs
    private_subnets = local.vpcs.us-east-2.private_subnets
    tags = local.common_tags
}

module "vpc_us_west_2" {
    source = "terraform-aws-modules/vpc/aws"
    version = "3.10.0"
    name = local.vpc.us-west-2.name
    cidr = local.vpcs.us-vpc_us_west_2.name
    enable_dns_hostnames = true
    enable_dns_support = true
    azs = local.vpcs.us-west-2.azs
    private_subnets = local.vpcs.us-west-2.private_subnets
    tags = local.common_tags
}

