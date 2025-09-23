provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}

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
  default     = "default_value"
}

provider "digitalocean" {
  token = var.do_token
}

resource "aws_instance" "shaka-g-server" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "t2.micro"
  provider      = aws.us_east_1
}

resource "aws_instance" "Choomu-server" {
  ami           = "ami-0123456789abcdef0"
  instance_type = "t2.micro"
  provider      = aws.us_west_2
}

resource "digitalocean_droplet" "baba-g-ka-ghanta" {
  image  = "ubuntu-22-04-x64"
  name   = "shaka-g-ka-droplet"
  region = "blr1"
  size   = "s-1vcpu-1gb"
}

