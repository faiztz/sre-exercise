terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.50.0" // Ensure your version supports Artifact Registry
    }
  }
}
provider "google" {
  credentials = file("./gcp/key.json")
  project     = var.project_id
  region      = var.region
}

resource "google_artifact_registry_repository" "my_repository" {
  provider = google

  location      = var.region // Choose the appropriate region
  repository_id = var.docker_repo_name
  format        = "DOCKER"
  description   = "Docker repository"

  labels = {
    env = "production"
  }
}

# Create a Cloud SQL PostgreSQL instance
resource "google_sql_database_instance" "postgresql_instance" {
  name             = var.instance_name
  database_version = "POSTGRES_12"
  region           = var.region
  settings {
    tier = var.db_tier
    ip_configuration {
      authorized_networks {
        name  = "all"
        value = "0.0.0.0/0"
      }
    }
  }

}

resource "google_sql_database" "postgresql_db" {
  name     = var.db_name
  instance = google_sql_database_instance.postgresql_instance.name
  charset  = "UTF8"
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.postgresql_instance.name
  password = var.db_password
}


resource "google_cloud_run_v2_service" "default" {
  name     = "alp-hello-world-app"
  location = var.region

  template {
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.docker_repo_name}/node-app:latest"

      startup_probe {
        tcp_socket {
          port = 8080
        }
      }
      env {
        name  = "PGUSER"
        value = var.db_user
      }
      env {
        name  = "PGHOST"
        value = google_sql_database_instance.postgresql_instance.public_ip_address
      }
      env {
        name  = "PGDATABASE"
        value = var.db_name
      }
      env {
        name  = "PGPASSWORD"
        value = var.db_password
      }
      env {
        name  = "PGPORT"
        value = var.db_port
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

resource "google_cloud_run_service_iam_binding" "default" {
  location = google_cloud_run_v2_service.default.location
  service  = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}



