output "pager_duty_id" {
   value = pagerduty_schedule.generic_schedule.id
}
output "final_schedule" {
   value = pagerduty_schedule.generic_schedule.final_schedule
}