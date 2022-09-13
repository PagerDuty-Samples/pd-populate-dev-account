terraform {
  required_providers {
    # see https://registry.terraform.io/providers/PagerDuty/pagerduty/2.6.2
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "2.6.2"
    }
  }
}
