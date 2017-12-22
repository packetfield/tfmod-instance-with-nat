output "internal_ip" {
  value = "${google_compute_instance.default.network_interface.0.address}"
}

output "network_ip" {
  value = "${google_compute_instance.default.network_interface.0.network_ip}"
}

output "nat_ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}

output "assigned_nat_ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.assigned_nat_ip}"
}
