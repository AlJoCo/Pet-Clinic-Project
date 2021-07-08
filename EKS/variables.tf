variable "qa_cluster_iam_role_arn" {
    description = "IAM Role for EKS Cluster"
}

# variable "iam_roles_eks_cluster" {
#     type = list(string)
#     description = "IAM Roles for EKS Cluster Dependencies"
# }

variable "qa_node_iam_role_arn" {
    description = "IAM Role for EKS Node Group"
}

# variable "iam_roles_eks_node" {
#     type = list(string)
#     description = "IAM Roles for EKS Cluster Dependencies"
# }

variable "available_subnets" {
    type = list(string)
    description = "Available subnets"
}

variable "subnet_ids" {
    description = "Subnet Ids"
}
