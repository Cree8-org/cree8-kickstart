## CREE8 KickStart: AWS Terraform

This module onboards an AWS account to the CREE8 Platform by creating **two** cross-account IAM roles:

- `CREE8-Service-Role` — assumed by the **CREE8 Application** to manage AWS infrastructure resources within your account. Trust policy requires an `ExternalId`. Attached with a least-privilege managed policy.
- `CREE8-Admin-Role` — assumed by **CREE8 Support Engineers** to login to your AWS account for support, patching, debugging and managing the CREE8 Platform. Trust policy does not use `ExternalId`. Attached with `AdministratorAccess` and `Billing`.

Both roles are created on every apply.

### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured with credentials that can create IAM roles/policies in the target account

### Steps

1. Clone the repository
2. `cd aws/terraform`
3. `export AWS_PROFILE=<your-profile-name>` (if using named profiles)
4. `terraform init`
5. `terraform apply -var 'external_id=<your-unique-external-id>'`

`external_id` must be 12–1224 characters and contain only alphanumeric, `-`, or `_` characters. Keep it secret and share it with the CREE8 Team over a secure channel.

### Outputs

After `terraform apply` completes, share the following with the CREE8 Team:

- `cree8_service_role_arn`
- `cree8_admin_role_arn`
- The `external_id` you used
