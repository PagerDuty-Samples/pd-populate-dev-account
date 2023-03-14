# SCHEDULE
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/schedule
resource "pagerduty_schedule" "checkout_service" {
  name      = "Checkout Service Schedule"
  time_zone = "America/Los_Angeles"

  layer {
    name                         = "Night Shift"
    start                        = "2022-10-27T20:00:00-08:00"
    rotation_virtual_start       = "2022-10-27T17:00:00-08:00"
    rotation_turn_length_seconds = 86400

    users = [
      pagerduty_user.lisa.id,
      pagerduty_user.bart.id
    ]

    restriction {
      type              = "daily_restriction"
      start_time_of_day = "07:00:00"
      duration_seconds  = 54000
    }
  }
}