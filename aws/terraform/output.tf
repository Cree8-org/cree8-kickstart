output "cree8_service_role_arn" {
  description = "ARN of the CREE8-Service-Role (used by the CREE8 Application). Share it with the CREE8 Team."
  value       = aws_iam_role.service.arn
}

output "cree8_admin_role_arn" {
  description = "ARN of the CREE8-Admin-Role (used by CREE8 Support Engineers). Share it with the CREE8 Team."
  value       = aws_iam_role.admin.arn
}
