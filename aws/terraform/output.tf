output "cree8_role_arn" {
  description = "ARN of the CREE8 Role to share with the CREE8 Team"
  value       = aws_iam_role.main.arn
}
