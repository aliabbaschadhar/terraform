# terraform {
#   required_providers {
#     digitalocean = {
#       source  = "digitalocean/digitalocean"
#       version = "~> 2.0"
#     }
#   }
# }

variable "do_token" {
  description = "Digital ocean PAT"
  type        = string
}


# provider "digitalocean" {
#   token = var.do_token
# }

variable "size_value" {
  description = "Size of the droplet"
  type        = string
}

variable "image_value" {
  description = "Image to be used in the droplet"
  type        = string
}

variable "name_value" {
  type        = string
  description = "Name of the droplet"
}

variable "region_value" {
  type        = string
  description = "In which region do we want to deploy the resource"
}


module "droplet_module" {
  source       = "./modules/droplet"
  do_token     = var.do_token
  image_value  = var.image_value
  name_value   = var.name_value
  region_value = var.region_value
  size_value   = var.size_value
}

# Add this output to expose the module's output
output "server_ip" {
  description = "The public IP address of your server"
  value       = module.droplet_module.server_ip
}
