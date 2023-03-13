# USERS
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/user
resource "pagerduty_user" "bart" {
  email       = "bart@foo.test"
  name        = "Bart Simpson"
  role        = "limited_user"
  description = "Spikey-haired boy"
  job_title   = "Rascal"
}