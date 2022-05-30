locals {
  repository = {
    id          = "backend-zentrity"
    description = "Backend repository"
    location    = var.location
    format      = "DOCKER"
  }
  labels = {
    production = {
      team        = "backend"
      environment = "production"
    }
  }
}

# Configure Google Artifact Registry resource
resource "google_artifact_registry_repository" "repository" {
  provider = google-beta

  repository_id = local.repository.id
  description   = local.repository.description
  location      = local.repository.location
  format        = local.repository.format
  labels        = local.labels.production
}