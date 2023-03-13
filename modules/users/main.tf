# USERS
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/user
# We default to using a description of "managed by terraform" from the PagerDuty Provider rather then setting anything for the user Description
resource "pagerduty_user" "bart" {
  email       = var.email
  name        = var.name
  role        = var.role
  job_title   = var.job_title
  time_zone   = var.time_zone
}