terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

provider "digitalocean" {
  token = var.do_token
}

# import {
#   id = "520618931"
#   to = digitalocean_droplet.existing_droplet
# }

# Paste the generate resource config here and you can use it. 
resource "digitalocean_droplet" "existing_droplet" {
  backups           = false
  droplet_agent     = null
  graceful_shutdown = null
  image             = "ubuntu-25-04-x64"
  ipv6              = false
  ipv6_address      = null
  monitoring        = false
  name              = "existing-droplet"
  region            = "blr1"
  resize_disk       = true
  size              = "s-1vcpu-1gb"
  ssh_keys          = null
  tags              = []
  user_data         = null
  volume_ids        = []
  vpc_uuid          = "be4a73ca-1c7f-4a44-a314-564cbd3e0bb6"
}
# But right now when we apply the terraform plan we will see it is try to add a resource but the resource already exists.
# So we need to import the resource first.
# To import the resource, run the following command:
# terraform import digitalocean_droplet.existing_droplet 520618931
