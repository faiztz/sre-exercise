variable "db_password" {
  description = "Password for the PostgreSQL database user"
  type        = string
}

variable "project_id" {

  description = "The ID of the Google Cloud project"

}

variable "region" {

  description = "The region in which resources will be created"

}

variable "instance_name" {

  description = "The name of the Cloud SQL instance"

}

variable "db_tier" {

  description = "The machine tier for the Cloud SQL instance"

}

variable "db_name" {

  description = "The name of the PostgreSQL database"

}