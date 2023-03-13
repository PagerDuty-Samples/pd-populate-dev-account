## PagerDuty User
This opionated module is used for building a pagerduty schedule


### Providers

This module takes one PagerDuty provider

### Example


```terraform
module "user1" {
  source = "./modules/users"
  email = "bart@foo.test"
  name = "Bart Simpson"
  job_title = "Rascal"
}
```
