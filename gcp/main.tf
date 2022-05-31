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

module "artifact_registry" {
  source   = "./modules/artifact-registry"
  location = var.project.region
}

module "workload_identity" {
  source     = "./modules/workload-identity"
  repository = var.github.repository
  id         = var.project.id
}

module "app_engine" {
  source = "./modules/app-engine"
  id     = var.project.id
}