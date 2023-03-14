# PagerDuty Populate Dev Account
This project provides an easy way to populate a [PagerDuty Developer Account](https://developer.pagerduty.com/sign-up/) with basic data. The project uses [Terraform](https://www.terraform.io/) and the [PagerDuty Provider](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs) for Terraform to create and manage the various objects in PagerDuty. To learn more about [Terraform](https://www.terraform.io/) head over to the product page at [HashiCorp](https://www.hashicorp.com/).

To learn more about using Terraform with PagerDuty, checkout [The How and Why of Using Terraform with PagerDuty](https://www.pagerduty.com/eng/how-why-terraform/).

## How to Use
- Sign up for a [Developer Account](https://developer.pagerduty.com/sign-up/). This account will provide you with a sandbox that will allow you to build and modify things in a PagerDuty account without messing with production data.
- [Generate a PagerDuty REST API key](https://support.pagerduty.com/docs/generating-api-keys).
- Using that key, create a .creds file and place your API key in it, this will be ignored by git and is a best practice to not accidently commit your credentials

```
provider "pagerduty" {
    token = "your_api_key_value"
}
```
- In this directory, run a `terraform init` in the command line.
- Run `terraform plan` to see what changes this file will implement. 
- If everything looks good in your plan, run `terraform apply`. This will show you the plan again and then ask you to confirm whether you want to perform the proposed actions. Type `yes`. 

When the process is complete your PagerDuty instance should now have all the resources listed below created. 

## Resources created
The code here will create the following resources in PagerDuty based on the content in the following files. 

- users.tf
  - **Users**
- teams.tf
  - **Teams**
  - **Team Memberships**
- - escelation_policy.tf
  - **Escalation Policy**
- schedules.tf
  - **Schedules**
- services.tf
  - **Services**
  - **Service Integrations**
  - **Business Service**
  - **Service Dependency**
- event_orchistration.tf
  - **Event Orchestration**
  
## Questions
If you have any questions or issues with this sample please post an Issue on this repository or create a post in the [PagerDuty Developer Community](https://community.pagerduty.com/forum/c/developer).