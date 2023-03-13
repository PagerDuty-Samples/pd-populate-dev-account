terraform {
  required_providers {
    # see https://registry.terraform.io/providers/PagerDuty/pagerduty/2.7.0
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "2.11.2"
    }
  }
}