variable "cree8_account_id" {
  type        = string
  description = "CREE8 Account ID"
  default     = "321267487758"

  validation {
    condition     = can(regex("^\\d{12}$", var.trusted_account_id))
    error_message = "Must be a valid 12-digit AWS account ID"
  }
}

variable "external_id" {
  type        = string
  description = "Unique External ID - Share it with the CREE8 Team"

  validation {
    condition     = can(regex("^[A-Za-z0-9\\-_]{12,1224}$", var.external_id))
    error_message = "Must be between 12 and 1224 characters and contain only alphanumeric, hyphen (-) and underscore (_) characters"
  }
}

variable "grant_admin_access" {
  type        = bool
  description = "Grant Admin Access"
  default     = true
}
