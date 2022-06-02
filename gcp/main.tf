terraform {
  required_version = ">= 1.1.7"

  required_providers {
    google-beta = {
      version = ">= 4.22.0"
    }
  }
}

provider "google-beta" {
  project = var.project.id
  region  = var.project.region
}

# GCP API services to enable
locals {
  services = toset([
    "artifactregistry.googleapis.com",
    "appengine.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudbuild.googleapis.com"
  ])
}

# Enable API services to project
resource "google_project_service" "services" {
  for_each                   = local.services
  project                    = var.project.id
  service                    = each.value
  disable_dependent_services = true
}

# Artifact Registry module
module "artifact_registry" {
  source     = "./modules/artifact-registry"
  location   = var.project.region
  depends_on = [
    google_project_service.services
  ]
}

# Workload Identity module
module "workload_identity" {
  source     = "./modules/workload-identity"
  repository = var.github.repository
  id         = var.project.id
  depends_on = [
    google_project_service.services
  ]
}

# App Engine module
module "app_engine" {
  source     = "./modules/app-engine"
  id         = var.project.id
  depends_on = [
    google_project_service.services
  ]
}