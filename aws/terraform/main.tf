resource "aws_iam_role" "service" {
  name                 = "CREE8-Service-Role"
  description          = "Cross-account role assumed by the CREE8 platform/application to manage AWS infrastructure resources (ExternalId required)."
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

resource "aws_iam_policy" "service_minimal" {
  name        = "CREE8-Service-Role-Policy"
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

resource "aws_iam_role_policy_attachment" "service_minimal" {
  role       = aws_iam_role.service.name
  policy_arn = aws_iam_policy.service_minimal.arn
}

resource "aws_iam_role" "admin" {
  name                 = "CREE8-Admin-Role"
  description          = "Cross-account role assumed by CREE8 Support Engineers to login, debug, patch and manage the CREE8 Platform within this AWS account."
  max_session_duration = 28800

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.cree8_account_id}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin_administrator" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "admin_billing" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}
