#locals

data "aws_called_identity" "current" {}
locals{
    prefix = "vpc-endpoints-multi-region-access"
    aws_account = data.aws_called_identity.current.account_id
    common_tags = {
        Project = local.prefix
        ManagedBy = "Terraform"
    }

 vpcs = {
    us-east-1 = {
        cidr = "10.0.0.0/16"
        region = "us-east-1"
        name = "${local.prefix}-us-east-1"
        azs = ["us-east-1a", "us-east-1b"]
        private_subnets= ["10.0.0.0/24" , "10.0.1.0/24"]
    }
    us-east-2 = {
        cidr = "10.0.1.0..0/16"
        region = "us-east-1"
        name = "${local.prefix}-us-east-1"
        azs = ["us-east-2a" , "us-east-2b"]
        private_subnets = ["10.0.0.0/24" , "10.0.1.0/24"]
    }
    us-west-2 = {
        cidr = "10.2.0.0/16"
        region = "us-west-2"
        name = "${local.prefix}-us-west-2"
        azs = ["us-west-2a" , "us-west-2b"]
        private_subnets = ["10.2.0.0/24" , "10.2.1.0/24"]
    }
  }
}