//$ terraform import kubernetes_config_map.example default/my-config

provider "aws" {
  region     = "us-west-2"
}

resource "aws_ecr_repository" "machine-id-checker" {
  name                 = "machine-id-checker-name"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 17.0"

  cluster_name       = "machine-id-viewer-cluster"  # Specify your desired cluster name
  cluster_version    = "1.29"             # Specify the Kubernetes version
  subnets            = ["subnet-0c4040330393fca7d", "subnet-08db8f3a289290c9e"]  # Specify your VPC subnets
  vpc_id             = "vpc-02c17ee8a6bae5e32"     # Specify your VPC ID

  # Specify node group configuration
  node_groups = {
    example_node_group = {
      desired_capacity = 2    # Specify the desired number of nodes
      instance_type    = "t2.micro"  # Specify the EC2 instance type for nodes
      instance_type    = "t2.micro"  
      name             = "machine-id-viewer-ng"  # Specify a shorter node group name
    }
  }
}