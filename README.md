## CREE8 KickStart: for Bring Your Own Cloud (BYOC)

This repository hosts IaaC for the BYOC Customers to onboard their accounts to the CREE8 platform.

### Overview
The CREE8 Platform support Bring Your Own Cloud (BYOC) for AWS, Azure, and GCP. This repository hosts the IaaC for the BYOC Customers to onboard their accounts to the CREE8 platform.

CREE8 recommends onboarding with Admin and Billing Access for CREE8 Team to manage the Infrastructure and Billing efficiently. If your organizatiion policy restricts Administrator Access, you can onboard with Minimal Access. We still recommend to have Billing Access to manage the billing efficiently.

### AWS

#### Automated via CloudFormation

Click on the respective Launch Stack button to onboard your account with Administrator or Minimal Access.

[![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=CREE8IAMAccess&templateURL=https://cree8-kickstart.s3.us-east-1.amazonaws.com/onboard-cree8-with-admin-access.yaml) with Administrator Access

[![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=CREE8IAMAccess&templateURL=https://cree8-kickstart.s3.us-east-1.amazonaws.com/onboard-cree8-with-minimal-access.yaml) with Minimal Access

The Launch Stack will take you to the CloudFormation Console, Click `Next` --> `Next` --> `Check "I acknowledge that AWS CloudFormation might create IAM resources with custom names." under Capabilities` --> `Next` --> `Add desired Tags` --> `Submit`.

Once the Stack creation is complete, retrieve the Role ARN from the Stack's output tab and share it with the CREE8 Team.

#### Manual via AWS Console

1. Navigate to [AWS IAM Console > Roles](https://console.aws.amazon.com/iam/home#/roles)
2. Click "Create role"
3. Select "AWS account" under "Trusted entity type"
4. Select "Another AWS account"
5. Enter the CREE8 Account ID: `321267487758`
8. Click "Next"

For Administrator Access:
1. Name the role: `CREE8-Admin-Role`
2. Search and attach these policies:
   - `AdministratorAccess`
   - `Billing`

For Minimal Access:
1. Name the role: `CREE8-Minimal-Role`
2. Search and attach these policies:
   - `AWSMarketplaceFullAccess`
   - `AmazonEC2FullAccess`
   - `AmazonVPCFullAccess`
   - `AmazonRoute53FullAccess`
   - `AmazonS3FullAccess`
   - `AmazonSNSFullAccess`
   - `AWSLambda_FullAccess`
   - `AmazonFSxFullAccess`
   - `CloudWatchFullAccess`
   - `CloudWatchFullAccessV2`
   - `AmazonEventBridgeFullAccess`
   - `Billing`

9. Click "Next"
10. Review the configuration and click "Create role"
11. Share the following with CREE8 team:
    - Role ARN (from the role summary page)
    - External ID you created in step 7

Note: The role ARN will be in the format: `arn:aws:iam::YOUR_ACCOUNT_ID:role/CREE8-Admin-Role` or `arn:aws:iam::YOUR_ACCOUNT_ID:role/CREE8-Minimal-Role`
