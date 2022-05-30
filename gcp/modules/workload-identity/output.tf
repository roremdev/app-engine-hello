output "service_account" {
  description = "Github Service Account Email"
  value       = google_service_account.github_service.email
}

output "github_identity_pool" {
  description = "Workload Identity Pool"
  value       = google_iam_workload_identity_pool.github_pool.name
}

output "github_pool_provider" {
  description = "Workload Identity Provider"
  value       = google_iam_workload_identity_pool_provider.github_provider
}