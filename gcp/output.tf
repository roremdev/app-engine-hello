output "service_account" {
  description = "Github Service Account Email"
  value       = module.workload_identity.service_account
}

output "workload_identity_provider" {
  description = "Workload Identity Provider"
  value       = module.workload_identity.github_pool_provider
}