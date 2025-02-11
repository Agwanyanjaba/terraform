terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  project = "qwiklabs-gcp-01-8a8ac849a259"
  region  = "us-central1"
  zone    = "us-central1-f"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}   

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  tags         = ["web", "dev"]

    boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }
    network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
}

resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}

