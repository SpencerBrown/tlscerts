variable "subject" {
  description = "Subject for self-signed certificate"
  type        = map(string)
  default = {
    O  = "MongoDB"
    OU = "Example"
    CN = "Self-Signed"
  }
}

variable "algorithm" {
  description = "Crypto algorithm (only RSA supported right now)"
  default     = "RSA"
}

variable "rsa_bits" {
  description = "Length of RSA key"
  default     = 2048
}

variable "valid_days" {
  description = "Number of days before certificate expires"
  default     = 365
}

variable "prefix" {
  description = "Prefix to assign to filenames"
  default     = "self-signed"
}

variable "directory" {
  description = "Directory where files should be written"
  default     = "tls-certs"
}

// Hosts for SAN list; default is no SAN list
variable "dns_names" {
  type    = list(string)
  default = []
}
