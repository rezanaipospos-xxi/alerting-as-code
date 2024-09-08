terraform {
  required_version = "~> 1.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.39.1"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.28.1"
    }
  }
}

variable "newrelic_personal_apikey" {}
variable "newrelic_account_id" {}
variable "newrelic_region" {}
variable "google_project_id" {}
variable "google_terraform_service_account" {}

provider "newrelic" {
    account_id = var.newrelic_account_id
    api_key = var.newrelic_personal_apikey
    region = var.newrelic_region
}

provider "google" {
  alias = "impersonation"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

#receive short-lived access token
data "google_service_account_access_token" "default" {
  provider               = google.impersonation
  target_service_account = var.google_terraform_service_account
  scopes                 = ["cloud-platform", "userinfo-email"]
  lifetime               = "3600s"
}

# default provider to use the the token
provider "google" {
  project         = var.google_project_id
  access_token    = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
}