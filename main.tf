/*
 * Variables
 */

variable "gcs_name" {}
variable "gcs_location" {}
variable "gcs_storage_class" {}

/*
 * Providers
 */

provider "google" {}

/*
 * Configuration
 */

resource "google_storage_bucket" "bucket" {
  name = var.gcs_name
  location = var.gcs_location
  storage_class = var.gcs_storage_class

  uniform_bucket_level_access = true
}

resource "google_cloudbuild_trigger" "trigger" {
    name = "go-ipfs"

    github {
        owner = "k3karthic"
        name = "go-ipfs"

        push {
            branch = "k3karthic"
        }
    }

    build {
        timeout = "900s"

        step {
            name = "docker"
            args = [
                "build",
                "-t",
                "gcr.io/$PROJECT_ID/myimage",
                "-f",
                "k3karthic/Dockerfile",
                "."
            ]
        }

        step {
            name = "gcr.io/$PROJECT_ID/myimage"
            args = [
                "bash",
                "-c",
                "cp /tmp/go-ipfs/cmd/ipfs/ipfs /myartifacts/ipfs"
            ]
            volumes {
                name = "artifactvol"
                path = "/myartifacts"
            }
        }

        step {
            name = "gcr.io/cloud-builders/gsutil"
            args = [
                "-m",
                "cp",
                "/myartifacts/ipfs",
                "gs://${google_storage_bucket.bucket.name}/ipfs"
            ]
            volumes {
                name = "artifactvol"
                path = "/myartifacts"
            }
        }
    }
}
