## PagerDuty User
This opionated module is used for building a user, it makes sure that a timezone is set to GMT if appropriate, and 

Specifically, it:

* Creates a user based on data passed

### Providers

This module takes one PagerDuty provider

### Example


```terraform
module "user1" {
  source = "../modules/user
  env    = "production"
  
  first_cidr_blocks  = [module.pd-vpc-usw2.cidr_block]
  second_cidr_blocks = [module.pd-vpc-euc1.cidr_block]
  first_tgw_id       = module.tgw-usw2.tgw_id
  second_tgw_id      = module.tgw-euc1.tgw_id

  providers = {
    aws.nw-first  = aws.nw-usw2
    aws.nw-second = aws.nw-euc1
  }
}
```