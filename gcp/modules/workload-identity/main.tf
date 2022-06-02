locals {
  roles = toset([
    "roles/editor",
    "roles/iam.serviceAccountUser",
    "roles/logging.logWriter"
  ])
}

# Service account to be used for federated auth to publish to GCR
resource "google_service_account" "github_service" {
  provider     = google-beta
  account_id   = "github-service"
  display_name = "GitHub Actions Service"
}

# TODO: Change project for github_actions_roles
resource "google_project_iam_binding" "project" {
  for_each = local.roles
  project  = var.id
  role     = each.value
  members  = [
    "serviceAccount:${google_service_account.github_service.email}"
  ]
}

# Identity pool for GitHub action based identity's access to Google Cloud resources
resource "google_iam_workload_identity_pool" "github_pool" {
  provider                  = google-beta
  workload_identity_pool_id = "github-identity-pool"
}

# Configuration for GitHub identity provider
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  provider                           = google-beta
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

resource "google_cloudbuild_trigger" "account-trigger" {
  project = var.id

  github {
    owner = "roremdev"
    name = "app-engine-hello"
    push {
      branch = "development"
    }
  }

#  trigger_template {
#    branch_name = "development"
#    repo_name   = var.repository
#  }

  service_account = google_service_account.github_service.id
  filename        = "cloudbuild.yaml"
  depends_on      = [
    google_project_iam_binding.project,
  ]

}