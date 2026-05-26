variable "cree8_account_id" {
  type        = string
  description = "CREE8 Account ID"
  default     = "321267487758"

  validation {
    condition     = can(regex("^\\d{12}$", var.cree8_account_id))
    error_message = "Must be a valid 12-digit AWS account ID"
  }
}

variable "external_id" {
  type        = string
  description = "Unique External ID for the CREE8-Service-Role - Share it with the CREE8 Team"

  validation {
    condition     = can(regex("^[A-Za-z0-9\\-_]+$", var.external_id)) && length(var.external_id) >= 12 && length(var.external_id) <= 1224
    error_message = "Must be between 12 and 1224 characters and contain only alphanumeric, hyphen (-) and underscore (_) characters"
  }
}
