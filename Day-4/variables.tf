variable "do_token" {
  description = "Digital ocean PAT"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token."
  type        = string
  sensitive   = true
}

variable "r2_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  default     = "f68badd75cec05f1f420e42be2c24b70"
}
