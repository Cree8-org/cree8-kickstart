## CREE8 KickStart: for Bring Your Own Cloud (BYOC)

This repository hosts IaC for BYOC customers to onboard their AWS, Azure, or GCP accounts to the CREE8 Platform.

### Overview

Onboarding provisions two cross-account IAM roles in your account. Both roles trust the CREE8 AWS account (`321267487758`) so that CREE8 can operate the platform on your behalf. They have different purposes and very different trust/permission profiles:

| Role | Used By | Trust | Permissions |
| --- | --- | --- | --- |
| `CREE8-Service-Role` | The **CREE8 Application** (automation) — to manage AWS infrastructure resources inside your account (compute, network, storage, etc.) | CREE8 account + **`ExternalId` required** | Minimal least-privilege policy (EC2, VPC, S3, FSx, Route53, Lambda, CloudWatch, ...) |
| `CREE8-Admin-Role` | **CREE8 Support Engineers** — to login to your AWS account for support, patching, debugging and managing the CREE8 Platform | CREE8 account (no `ExternalId`) | `AdministratorAccess` + `Billing` |

Both roles are always created together. The `ExternalId` only applies to `CREE8-Service-Role`; you must generate a unique value and share it with the CREE8 Team along with both Role ARNs.

### AWS

#### Automated via CloudFormation

Click the Launch Stack button below. It creates both roles in a single stack.

[![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=CREE8IAMAccess&templateURL=https://cree8-kickstart.s3.us-east-1.amazonaws.com/onboard-cree8.yaml)

In the CloudFormation Console: click `Next` → enter an `ExternalId` (12–1224 alphanumeric / `-` / `_`) and keep the default `CREE8AccountId` → `Next` → check **"I acknowledge that AWS CloudFormation might create IAM resources with custom names."** under Capabilities → `Next` → add any Tags → `Submit`.

Once the stack is `CREATE_COMPLETE`, open the **Outputs** tab and share the following with the CREE8 Team:

- `ServiceRoleArn`
- `AdminRoleArn`
- The `ExternalId` you chose (keep this secret; share over a secure channel)

#### Automated via Terraform

See [`aws/terraform/README.md`](./aws/terraform/README.md).

#### Manual via AWS Console

If you prefer to create the roles by hand, repeat the following twice — once for each role.

1. Navigate to [AWS IAM Console > Roles](https://console.aws.amazon.com/iam/home#/roles)
2. Click **Create role**
3. Select **AWS account** → **Another AWS account**
4. Enter the CREE8 Account ID: `321267487758`

##### Role 1 — `CREE8-Service-Role` (for the CREE8 Application)

5. Check **Require external ID** and enter a unique value you generate (12–1224 chars, `[A-Za-z0-9_-]`). Save it — you'll share it with CREE8.
6. Click **Next**, then create and attach a customer-managed policy named `CREE8-Service-Role-Policy` matching the document in [`aws/cloudformation/onboard-cree8.yaml`](./aws/cloudformation/onboard-cree8.yaml) (the `Policies` block under `CREE8ServiceRole`).
7. Name the role: `CREE8-Service-Role`
8. Click **Create role**

##### Role 2 — `CREE8-Admin-Role` (for CREE8 Support Engineers)

5. Leave **Require external ID** unchecked.
6. Click **Next** and attach these AWS-managed policies:
   - `AdministratorAccess`
   - `Billing`
7. Name the role: `CREE8-Admin-Role`
8. Click **Create role**

##### Share with CREE8

Share the following with the CREE8 Team:

- `CREE8-Service-Role` ARN — `arn:aws:iam::YOUR_ACCOUNT_ID:role/CREE8-Service-Role`
- `CREE8-Admin-Role` ARN — `arn:aws:iam::YOUR_ACCOUNT_ID:role/CREE8-Admin-Role`
- The `ExternalId` you chose for `CREE8-Service-Role` (over a secure channel)
