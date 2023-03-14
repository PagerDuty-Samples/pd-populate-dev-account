# escalation policy
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/escalation_policy
resource "pagerduty_escalation_policy" "checkout_service" {
  name      = "Checkout Service Escalation Policy"
  num_loops = 3

  rule {
    escalation_delay_in_minutes = 30
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.checkout_service.id
    }
  }
}