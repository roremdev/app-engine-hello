output "github_service_id" {
  description = "Github Service ID"
  value       = module.workload_identity.github_service_id
}

output "github_service_email" {
  description = "Github Service Email"
  value       = module.workload_identity.github_service_email
}

output "github_pool_name" {
  description = "Github Service Account Pool Name"
  value       = module.workload_identity.github_pool_name
}
