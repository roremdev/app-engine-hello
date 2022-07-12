output "service_account" {
  description = "Elastic Container Registry"
  value       = aws_ecr_repository.ecr_repository
}