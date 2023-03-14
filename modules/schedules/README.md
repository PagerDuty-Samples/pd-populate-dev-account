## PagerDuty User
This opionated module is used for building a pagerduty schedule


### Providers

This module takes one PagerDuty provider

### to-do's
Make the layers and restrictions for_each able

### Example


```terraform
module "schedule1" {
  source = "./modules/schedules"
  name = "Checkout Service Schedule"
  time_zone = "America/Los_Angeles"
  layers = {
    name                         = "Night Shift"
    start                        = "2022-10-27T20:00:00-08:00"
    rotation_virtual_start       = "2022-10-27T17:00:00-08:00"
    rotation_turn_length_seconds = 86400
    users = [module.user1.pager_duty_id, module.user2.pager_duty_id],
    teams = [pagerduty_team.simpson.id]
     restriction = {
      type              = "daily_restriction"
      start_time_of_day = "07:00:00"
      duration_seconds  = 54000
    }
  }
}
```
