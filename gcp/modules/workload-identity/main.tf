# Service account to be used for federated auth to publish to GCR
resource "google_service_account" "github_service" {
  provider = google-beta

  account_id   = "github-service"
  display_name = "Service Account impersonated in GitHub Actions"
}

# Identity pool for GitHub action based identity's access to Google Cloud resources
resource "google_iam_workload_identity_pool" "github_pool" {
  provider                  = google-beta
  workload_identity_pool_id = "github-identity-pool"
}

# Configuration for GitHub identity provider
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  provider = google-beta

  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  attribute_mapping                  = {
    "google.subject"       = "assertion.sub"
    "attribute.aud"        = "assertion.aud"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri        = "https://token.actions.githubusercontent.com"
    allowed_audiences = []
  }
}

# IAM policy bindings to the service account resources created by GitHub identify provider
resource "google_service_account_iam_member" "github_service_policy" {
  provider           = google-beta
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${var.repository}"
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.github_service.id
}