# tfmod-instance-with-nat
Instance (with external storage) and a NAT IP + firewall


# TODO:
- seperate firewall module
- nat ip optional

# Example usage


```
# create the data disk

resource "google_compute_disk" "disk1" {
    name  = "${var.env}-${var.component}-1-data"
    type  = "pd-ssd"
    zone  = "${var.zone}"
    size  = "${var.data_volume_size}"
}

# get a static (nat) IP
resource "google_compute_address" "default" {
  name = "${var.env}-${var.component}-static"
}

# call the module
module "instance1" {
  instance_id   = "1"
  data_disk     = "${google_compute_disk.disk1.self_link}"
  source        = "github.com/packetfield/tfmod-instance-with-nat.git?ref=0.1"
  size          = "${var.size}"
  component     = "${var.component}"
  env           = "${var.env}"
  zone          = "${var.zone}"
  region        = "${var.region}"
  project       = "${var.project}"
  nat_ip        = "${google_compute_address.default.address}"
  scopes        = "${var.scopes}"
}

## output the data received back from the module
output "internal_ip" {
  value = "${module.instance1.internal_ip}"
}
output "network_ip" {
  value = "${module.instance1.network_ip}"
}
output "nat_ip" {
  value = "${module.instance1.nat_ip}"
}
output "assigned_nat_ip" {
  value = "${module.instance1.assigned_nat_ip}"
}

```

## example variables

```
size = "g1-small"
region = "europe-west2"
zone = "europe-west2-a"
data_volume_size = 20

# Scopes

scopes = [
  "https://www.googleapis.com/auth/cloud-platform",
  "https://www.googleapis.com/auth/compute",
  ]
```
