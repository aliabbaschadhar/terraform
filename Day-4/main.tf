provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "droplet-shaku" {
  image  = "ubuntu-22-04-x64"
  region = "blr1"
  size   = "s-1vcpu-1gb"
  name   = "shaku-ka-droplet"
}
