provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "droplet-shaku" {
  image  = "ubuntu-22-04-x64"
  region = "blr1"
  size   = "s-1vcpu-1gb"
  name   = "shaku-ka-droplet"
}

# For locking purposes so that only one person can apply changes at a time
# resource "aws_dynamodb_table" "terraform-lock" {
#   name         = "terraform-lock"
#   billing_mode = "PAY_PER_REQUEST"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   hash_key = "LockID"
# }
