output "github_service_id" {
  description = "Github Service ID"
  value       = google_service_account.github_service.id
}

output "github_service_email" {
  description = "Github Service Email"
  value       = google_service_account.github_service.email
}

output "github_pool_name" {
  description = "Workload Identity Pool"
  value       = google_iam_workload_identity_pool.github_pool.name
}

output "github_pool_provider" {
  description = "Workload Identity Provider"
  value       = google_iam_workload_identity_pool_provider.github_provider.name
}