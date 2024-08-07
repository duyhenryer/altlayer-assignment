module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = "${local.cluster_name}-eks"
  cluster_version = "${local.eks_version}"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

#   cluster_addons = {
#     aws-ebs-csi-driver = {
#       service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
#     }
    # coredns                = {}
    # eks-pod-identity-agent = {}
    # kube-proxy             = {}
    # vpc-cni                = {}
#   }

  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium", "m5.large"]
    ami_type = "AL2_x86_64"
    disk_size = 20
  }

  eks_managed_node_groups = {
    # on-demand = {
    #     name = "node-on-demand"

    #     instance_types = ["t3.small"]
    #     capacity_type  = "ON_DEMAND"

    #     min_size     = 1
    #     max_size     = 1
    #     desired_size = 1

    #       labels = {
    #         role = "on-demand"
    #       }
    # }
    spot = {
        name = "node-spot-02"
        min_size     = 2
        max_size     = 5
        desired_size = 2

          labels = {
            role = "spot"
          }

        instance_types = ["t3.large"]
        capacity_type  = "SPOT"
    }

    # spot = {
    #     name = "node-spot-01"
    #     min_size     = 1
    #     max_size     = 3
    #     desired_size = 1

    #       labels = {
    #         role = "spot"
    #       }

    #     #   taints = [{
    #     #     key    = "market"
    #     #     value  = "spot"
    #     #     effect = "NO_SCHEDULE"
    #     #   }]

    #     instance_types = ["t3.small"]
    #     capacity_type  = "SPOT"
    # }
  }


  tags = {
    Environment = "${local.env}"
  }
}