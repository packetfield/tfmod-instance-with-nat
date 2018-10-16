
resource "google_compute_instance" "default" {
  allow_stopping_for_update = "${var.allow_stopping_for_update}"
  name                      = "${var.env}-${var.component}-${var.instance_id}"
  machine_type              = "${var.size}"
  zone                      = "${var.zone}"
  tags                      = [
    "${var.component}",
    "${var.env}",
    "${var.env}-${var.component}",
    "id-${var.instance_id}"
    ]
  boot_disk{
    initialize_params {
      size                  = "${var.boot_disk_size}"
      image                 = "${var.image}"
    }
  }

  attached_disk {
    source = "${var.data_disk}"
  }

  network_interface {
    network = "default"
    access_config {
      // gimme a public NAT IP
      nat_ip = "${var.nat_ip}"
    }
  }

 service_account {
    scopes = [
      "${var.scopes}"
    ]
  }
}

