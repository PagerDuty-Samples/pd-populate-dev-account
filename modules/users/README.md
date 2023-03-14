## PagerDuty User
This opionated module is used for building a user, it makes sure that a timezone is set to GMT if appropriate, and 

Specifically, it:

* Creates a user based on data passed

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
