variable "do_token" {
  description = "value for digital PAT"
  type        = string
}

variable "image_value" {
  description = "Image value e.g. ubuntu"
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "region_value" {
  description = "Region where resource will be created!"
  type        = string
  default     = "blr1"
}

variable "size_value" {
  description = "Size value for digital ocean droplet"
  type        = string
  default     = "s-1vcpu-1gb"
}
