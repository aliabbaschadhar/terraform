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

provider "digitalocean" {
  token = var.do_token
}

variable "size_value" {
  description = "Size of the droplet"
  type        = string
}

variable "image_value" {
  description = "Image to be used in the droplet"
  type        = string
}

variable "name_value" {
  description = "Name of the droplet"
  type        = string
}

variable "region_value" {
  description = "In which region do we want to deploy the resource"
  type        = string
}
resource "digitalocean_droplet" "server-a-shaka-g" {
  size   = var.size_value
  image  = var.image_value
  name   = var.name_value
  region = var.region_value
}

output "server_ip" {
  description = "The public IP address of your server"
  value       = digitalocean_droplet.server-a-shaka-g.ipv4_address
}
