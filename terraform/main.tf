module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.14.0"

  cluster_name                   = local.name
  cluster_version                = local.cluster_version
  vpc_id                         = data.aws_vpc.app.id
  subnet_ids                     = data.aws_subnets.public.ids
  control_plane_subnet_ids       = data.aws_subnets.public.ids
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    # default = {
    #   instance_types = ["t3a.medium", "t3a.large"]
    #   capacity_type  = "SPOT"
    # }

    default-arm = {
      ami_type                   = "AL2_ARM_64"
      ami_id                     = data.aws_ami.eks_default_arm.image_id
      enable_bootstrap_user_data = true
      instance_types             = ["t4g.medium"]
      capacity_type              = "SPOT"
    }
  }

  enable_cluster_creator_admin_permissions = true
}

# TODO: aws-auth configmap
# arn:aws:iam::<acc id>:root
