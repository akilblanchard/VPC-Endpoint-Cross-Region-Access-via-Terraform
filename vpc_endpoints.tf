#us-east-1-Securtiy-Group

resource "aws_security_group" "endpoints_us_east_1"{
    name = "${local.prefix}-endpoints"
    description = "Allow all HTTPS traffic"
    vpc = module.vpc_us_east_1.vpc_id
    ingress = [
        {
            description = "HTTPS Traffic"
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["10.0.0.0/8"]
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            security_groups = []
            self = false
        }
    ]
    egress = [
    {
        description = "ALL Traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }
    ]
    tags = local.common_tags
}

#us-east-1-Endpoint
module "endpoints_us_east_1" {
    source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
    version = "3.10.0"
    vpc_id             = module.vpc_us_east_1.vpc_id
  security_group_ids = [aws_security_group.endpoints_us_east_1.id]

  endpoints = {
    s3 = {
      # interface endpoint
      service             = "s3"
      subnet_ids = module.vpc_us_east_1.private_subnets
      tags                = { Name = "s3-vpc-endpoint" }
    },
  tags = local.common_tags
}
}
#us-east-2
resource "aws_security_group" "endpoints_us_east_2"{
    name = "${local.prefix}-endpoints"
    description = "Allow all HTTPS traffic"
    vpc = module.vpc_us_east_2.vpc_id
    ingress = [
        {
            description = "HTTPS Traffic"
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["10.0.0.0/8"]
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            security_groups = []
            self = false
        }
    ]
    egress = [
    {
        description = "ALL Traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }
    ]
    tags = local.common_tags
    provider = {
        aws = aws.us-east-2
    }
}





