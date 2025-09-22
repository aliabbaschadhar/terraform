# Let create a simple droplet on digital ocean using terraform.

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  description = "Digital ocean PAT"
  type        = string
}

# Configure Digital ocean provider
provider "digitalocean" {
  token = var.do_token
}

# Create a simple droplet (VM on digital ocean)
resource "digitalocean_droplet" "shaka-g-ka-droplet" {
  image  = "ubuntu-22-04-x64"
  name   = "shaka-g-ka-droplet"
  region = "blr1"
  size   = "s-1vcpu-1gb"
}

output "server_ip" {
  description = "The public IP address of your server"
  value       = digitalocean_droplet.shaka-g-ka-droplet.ipv4_address
}
