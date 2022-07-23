output "connect_computer_to_cluster" {
  description = "Configure your computer to communicate with your cluster"
  value       = join("", ["aws eks update-kubeconfig ", "--region ", var.region, " --name ", aws_eks_cluster.eks_cluster.name])
}


output "multi_shop_certificate_arn" {
  description = "The arn of the multi-shop certificate"
  value       = aws_acm_certificate.multi_shop_certificate.arn
}


output "aws_load_balancer_controller_role_arn" {
  description = "Arn role for aws load balancer"
  value       = aws_iam_role.load_balancer_role_trust_policy.arn
}


output "cluster_name" {
  description = "EKS cluster Name."
  value       = aws_eks_cluster.eks_cluster.name
}


output "endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.eks_cluster.endpoint
}


output "kubeconfig-certificate-authority-data" {
  description = "kubectl config generated by the eks cluster"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}