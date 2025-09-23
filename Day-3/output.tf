output "droplet-ip" {
  description = "Droplet public ip"
  value       = digitalocean_droplet.modules_terraform.ipv4_address
}
