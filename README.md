# PagerDuty Populate Dev Account
To learn more about using Terraform with PagerDuty, checkout [The How and Why of Using Terraform with PagerDuty](https://www.pagerduty.com/eng/how-why-terraform/).

## How to Use
- Sign up for a [Developer Account](https://developer.pagerduty.com/sign-up/). This account will provide you with a sandbox that will allow you to build and modify things in a PagerDuty account without messing with production data.
- [Generate a PagerDuty REST API key](https://support.pagerduty.com/docs/generating-api-keys).
- Using that key, create a .creds file and place your API key in it, this will be ignored by git and is a best practice to not accidentally commit your credentials to git.
- in reality you want to use some type of secrets manager and use a session variable to store your API credentials as they are the `keys to your PagerDuty kingdom`.  but for the purposes of getting you up and running the .creds file is ok for now
  - Talk to your security department and use common sense in storing critical data
## Company Examples

### Acme Overview
Please consult the [Acme Inc.](./acme/README.md) readme for full details
```
At Acme Inc, our mission is to provide high-quality widgets that meet the needs of our customers while maintaining the highest levels of customer service and satisfaction. We strive to be a leader in the industry by continuously improving our products, processes, and customer experiences.
```
Acme is deploying PagerDuty for two main teams right now:
- Customer facing helpdesk
  - two teams, 6 people
- Sysadmin type people
  - 16 engineers
- a few other important users

This terraform demonstrates
- Users
- Teams
- Custom Schedules
- Business Services
- Technical Services
- Event Orchestration
- probably some other sexy things too
```



## Questions
If you have any questions or issues with this sample please post an Issue on this repository or create a post in the [PagerDuty Developer Community](https://community.pagerduty.com/forum/c/developer).