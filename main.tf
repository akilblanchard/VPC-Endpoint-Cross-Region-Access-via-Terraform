
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


#VPC Peering
resource "aws_vpc_peering_connection_accepter" "us_east-1-us_west-2" {
    provider = aws
    vpc_peering_connection_id = aws_vpc_peering_connection.us_west-2-us_east_1.vpc_id
    auto_accept = true
    tags = local.common_tags
  
}

resource "aws_vpc_peering_connection" "us_east_1-us_west-2" {
    vpc_id = module.vpc_us_west_2.vpc_id
    peer_vpc_id = module.vpc_us_east_1.vpc_cidr_blockpeer_owner_id
    peer_owner_id = local.aws_account
    peer_region = "us-east-1"
    auto_accept = false
    tags = local.common_tags
    provider = aws.us-west-2
}

resource "aws_route" "us_east_1-_us_west_2" {
    count = length(module.vpc_us_east_1.private_route_table_ids)
    route_table_id = module.vpc_us_east_1.private_route_table_ids [count.index]
    destination_cidr_block = module.vpc_us_west_2.vpc_cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection_accepter.us_east-1-us_west-2.id

}


resource "aws_vpc_peering_connection" "us_west-2-us_east2"{
    vpc_id = module.vpc_us_west_2.vpc_id
    peer_vpc_id = module.vpc_us_east_2.vpc_id
    peer_owner_id = local.aws_account
    peer_region = "us_east_2"
    auto_accept = false
    tags = local.common_tags
    provider = aws.us-west-2
}

resource "aws_route" "us_west-2-us_east_2"{
    count = length(module.vpc_us_west_2.private_route_table_ids)
    route_table_id = module.vpc_us_west_2.private_route_table_ids[count.index]
    destination_cidr_block = module.vpc_us_east_2.vpc_cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.us_west-2-us_east_2.id
}

resource "aws_route" "us_east_2-us_west-2"{
count = length(module.vpc_us_east_2.private_route_table_ids)[count.index]
route_table_id = module.vpc_us_east_2.private_route_table_ids[count.index]
destination_cidr_block = module.vpc_us_west_2.vpc_cidr_block
vpc_peering_connection_id = aws_vpc_peering_connection_accepter.us_east_2-us_west-2.id
provider = aws.us-east-2
}