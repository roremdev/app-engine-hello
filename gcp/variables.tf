variable "project" {
  description = "Google Cloud project information"
  nullable    = false

  type = object({
    id     = string
    region = string
  })
  default = {
    id     = "zentrity-352100"
    region = "us-central1"
  }
}

variable "github" {
  description = "GitHub information repository"
  nullable    = false

  type = object({
    repository = string
  })
  default = {
    repository = "roremdev/app-engine-hello"
  }
}