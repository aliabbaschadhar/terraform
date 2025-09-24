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

variable "vault_role_id" {
  description = "Vault AppRole Role ID"
  type        = string
  sensitive   = true
}

variable "vault_secret_id" {
  description = "Vault AppRole Secret ID"
  type        = string
  sensitive   = true
}

provider "digitalocean" {
  token = var.do_token
}

provider "vault" {
  address          = "http://68.183.87.21:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = var.vault_role_id
      secret_id = var.vault_secret_id
    }
  }
}

# To read the resource in terraform we use the data block
data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "test-secret"
}

resource "digitalocean_droplet" "droplet" {
  image  = "ubuntu-22-04-x64"
  size   = "s-1vcpu-1gb"
  name   = "example-droplet"
  region = "blr1"
  tags   = ["secret-${data.vault_kv_secret_v2.example.data["username"]}"]
}

output "example_data" {
  value     = data.vault_kv_secret_v2.example.data
  sensitive = true
}

output "public_ip" {
  value = digitalocean_droplet.droplet.ipv4_address

}
