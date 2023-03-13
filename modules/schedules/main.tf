# USERS
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/user
# as rendered our terraform would look like this however we are doing it the dynamic way
# resource "pagerduty_schedule" "checkout_service" {
#   name      = "Checkout Service Schedule"
#   time_zone = "America/Los_Angeles"

#   layer {
#     name                         = "Night Shift"
#     start                        = "2022-10-27T20:00:00-08:00"
#     rotation_virtual_start       = "2022-10-27T17:00:00-08:00"
#     rotation_turn_length_seconds = 86400

#     users = [
#       pagerduty_user.lisa.id,
#       pagerduty_user.bart.id
#     ]

#     restriction {
#       type              = "daily_restriction"
#       start_time_of_day = "07:00:00"
#       duration_seconds  = 54000
#     }
#   }
# }

resource "pagerduty_schedule" "checkout_service" {
  name      = var.name
  time_zone = var.time_zone

  layer {
    name                         = var.layers.name
    start                        = var.layers.start
    rotation_virtual_start       = var.layers.rotation_virtual_start
    rotation_turn_length_seconds = var.layers.rotation_turn_length_seconds

    users = var.layers.users
    restriction {
    type                =  var.layers.restriction.type
    start_time_of_day   =  var.layers.restriction.start_time_of_day
    duration_seconds    =  var.layers.restriction.duration_seconds
        }
  }

}
