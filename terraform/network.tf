module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                    = local.name
  cidr                    = "10.1.0.0/16"
  azs                     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnets          = cidrsubnets("10.1.0.0/16", 4, 4, 4)
  map_public_ip_on_launch = true
  enable_nat_gateway      = false
  enable_vpn_gateway      = false
  tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = "1"
  }
}
