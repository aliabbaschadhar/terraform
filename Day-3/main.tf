terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "modules_terraform" {
  image  = var.image_value
  region = var.region_value
  size   = var.size_value
  name   = "shaka-g-ka-droplet"
}

