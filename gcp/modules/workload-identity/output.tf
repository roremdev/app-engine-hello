output "service_account" {
  value = google_service_account.github_service.email
}

output "github_pool_provider" {
  value = google_iam_workload_identity_pool_provider.github_provider.name
}