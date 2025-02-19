## CREE8 KickStart: for Bring Your Own Cloud (BYOC)

This repository hosts IaaC for the BYOC Customers to onboard their accounts to the CREE8 platform.

### Overview
The CREE8 Platform support Bring Your Own Cloud (BYOC) for AWS, Azure, and GCP. This repository hosts the IaaC for the BYOC Customers to onboard their accounts to the CREE8 platform.

CREE8 recommends onboarding with Admin and Billing Access for CREE8 Team to manage the Infrastructure and Billing efficiently. If your organizatiion policy restricts Administrator Access, you can onboard with Minimal Access. We still recommend to have Billing Access to manage the billing efficiently.

### AWS

#### Automated via Terraform

##### Prerequisites:
- Terraform - [Install Terraform](https://developer.hashicorp.com/terraform/downloads)
- AWS CLI (with IAM Access) - [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Configure AWS CLI with Access to the desired AWS Account (BYOC)

##### Steps:
1. Clone the repository
2. Navigate to the `aws/terraform` directory
3. Run `export AWS_PROFILE=<your-profile-name>` if using named profiles
3. Run `terraform init`
4. Run `terraform apply`

Once the `terraform apply` is complted. The output will have the Role ARN. Share the Role ARN with the CREE8 Team.
