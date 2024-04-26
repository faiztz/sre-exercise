provider "google" {
  credentials = file("./gcp/key.json")
  project     = "inbound-muse-421417"
  region      = "us-central1"
}


# Create a Cloud SQL PostgreSQL instance

resource "google_sql_database_instance" "postgresql_instance" {

  name             = var.instance_name

  database_version = "POSTGRES_12"

  region           = var.region

  settings {

    tier = var.db_tier

    # Set the replication type to synchronous for high availability

    replication_type = "SYNCHRONOUS"

  }

}

# Create a PostgreSQL database

resource "google_sql_database" "postgresql_db" {

  name     = var.db_name

  instance = google_sql_database_instance.postgresql_instance.name

  charset  = "UTF8"

}

resource "google_sql_user" "users" {
  name     = "admin"
  instance = google_sql_database_instance.postgresql_instance.name
  password = var.db_password
}


resource "google_cloud_run_service" "default" {
  name     = "hello-world-app"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/inbound-muse-421417/hello-world-app"
        
        env {
          name  = "PGUSER"
          value = "postgres"
        }
        env {
          name  = "PGHOST"
          value = "/cloudsql/inbound-muse-421417:us-central1:my-postgresql-instance"
        }
        env {
          name  = "PGDATABASE"
          value = "message"
        }
        env {
          name  = "PGPASSWORD"
          value = "Pass@word1"
        }
        env {
          name  = "PGPORT"
          value = "5432"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}



