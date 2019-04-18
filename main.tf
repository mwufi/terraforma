// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("~/Desktop/OriginalMonkey.json")}"
  project = "carbide-sweep-173716"
  region = "us-east1"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
  name = "flask-vm-${random_id.instance_id.hex}"
  machine_type = "f1-micro"
  zone = "us-east1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Make sure flask is installed on all new instances for later steps
  metadata_startup_script = "${file("./resources/start.sh")}"

  // SSH
  metadata {
    sshKeys = "zentang:${file("~/.ssh/id_rsa.pub")}"
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }
}

resource "google_compute_firewall" "default" {
  name = "flask-app-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["5000"]
  }
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}