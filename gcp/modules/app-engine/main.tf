locals {
  app = {
    id       = var.id
    location = "us-central"
  }
}


resource "google_app_engine_application" "app" {
  project     = local.app.id
  location_id = local.app.location
}