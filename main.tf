// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("~/Desktop/OriginalMonkey.json")}"
  project = "carbide-sweep-173716"
  region = "us-east1"
}

// Specify the image we want
data "google_compute_image" "my_image" {
  family  = "tf-latest-gpu"
  project = "deeplearning-platform-release"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
  name = "flask-vm-${random_id.instance_id.hex}"
  machine_type = "n1-standard-4"
  zone = "us-east1-c"

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.my_image.self_link}"
    }
  }

  // Add a GPU
  guest_accelerator {
    count = 1
    type = "nvidia-tesla-k80"
  }

  // Need to terminate GPU on maintenance
  scheduling {
    on_host_maintenance = "TERMINATE"
  }

  // Make sure flask is installed
  metadata_startup_script = "${file("./resources/flask.sh")}"

  // SSH
  metadata {
    sshKeys = "zentang:${file("~/.ssh/id_rsa.pub")}"
    install-nvidia-driver = true
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
    ports = ["5000", "8000", "8888-8891", "6006"]
  }
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}