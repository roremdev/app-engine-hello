resource "google_app_engine_application" "app" {
  project     = var.id
  location_id = "us-central"
}
