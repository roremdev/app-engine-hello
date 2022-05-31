output "service_account" {
  description = "Github Service Account Email"
  value       = module.workload_identity.service_account
}

output "github_pool_provider" {
  description = "Workload Identity Provider"
  value       = module.workload_identity.github_pool_provider
}