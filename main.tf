provider "aws" {
  region = "us-west-2"
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-cluster"
  role_arn = aws_iam_role.my_eks_cluster_role.arn

  vpc_config {
    subnet_ids = ["subnet-0bbc9e751405e4539", "subnet-004112c4319c95a09"]
    security_group_ids = ["sg-0f8856f2e3f448ff6"]
  }
}

resource "aws_iam_role" "my_eks_cluster_role" {
  name               = "my-eks-cluster-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
