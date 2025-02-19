resource "aws_iam_role" "main" {
  name                 = "CREE8-CrossAccount-Admin-Role"
  description          = "Cross-account role for CREE8 platform administration"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.cree8_account_id}:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "aws:PrincipalType" = "AWS"
            "sts:ExternalId"    = var.external_id
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin" {
  count      = var.grant_admin_access ? 1 : 0
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy" "minimal" {
  count       = var.grant_admin_access ? 0 : 1
  name        = "CREE8-Minimal-Role-Policy"
  description = "CREE8 Platform Minimal Access Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "sns:*",
          "lambda:*",
          "route53:*",
          "s3:*",
          "vpc:*",
          "elasticfilesystem:*",
          "fsx:*",
          "storagegateway:*",
          "aws-marketplace:*",
          "aws-marketplace-management:*",
          "elastic-inference:*",
          "elasticloadbalancing:*",
          "globalaccelerator:*",
          "cloudwatch:*",
          "logs:*",
          "events:*",
          "iam:PassRole",
          "cloudtrail:*",
          "autoscaling:*",
          "application-autoscaling:*",
          "schemas:*",
          "states:*",
          "pipes:*",
          "scheduler:*"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["iam:CreateServiceLinkedRole"]
        Resource = "arn:aws:iam::*:role/aws-service-role/*"
        Condition = {
          StringLike = {
            "iam:AWSServiceName" = [
              "ec2.amazonaws.com",
              "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com",
              "spotfleet.amazonaws.com",
              "transitgateway.amazonaws.com",
              "fsx.amazonaws.com",
              "storagegateway.amazonaws.com",
              "events.amazonaws.com",
              "autoscaling.amazonaws.com",
              "application-autoscaling.amazonaws.com"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "minimal" {
  count      = var.grant_admin_access ? 0 : 1
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.minimal.arn
}

resource "aws_iam_role_policy_attachment" "billing" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}
