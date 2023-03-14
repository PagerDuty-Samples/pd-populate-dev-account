# SERVICES
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service
resource "pagerduty_service" "api" {
  name              = "Checkout API"
  escalation_policy = pagerduty_escalation_policy.checkout_service.id
  alert_creation    = "create_alerts_and_incidents"
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service
resource "pagerduty_service" "db" {
  name              = "Checkout DB"
  escalation_policy = pagerduty_escalation_policy.checkout_service.id
  alert_creation    = "create_alerts_and_incidents"
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service
resource "pagerduty_service" "unrouted" {
  name              = "Checkout Unrouted"
  escalation_policy = pagerduty_escalation_policy.checkout_service.id
  alert_creation    = "create_alerts_and_incidents"

  auto_pause_notifications_parameters {
    enabled = true
    timeout = 900
  }
}

# BUSINESS SERVICES
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/business_service
resource "pagerduty_business_service" "api_business" {
  name = "API Business"
}

# SERVICE DEPENDENCY
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service_dependency
resource "pagerduty_service_dependency" "api_service_dependency" {
  dependency {
    dependent_service {
      id   = pagerduty_business_service.api_business.id
      type = "business_service"
    }

    supporting_service {
      id   = pagerduty_service.api.id
      type = "service"
    }
  }
}


resource "pagerduty_service_dependency" "api_db_service_dependency" {
  dependency {
    dependent_service {
      id   = pagerduty_business_service.api_business.id
      type = "business_service"
    }

    supporting_service {
      id   = pagerduty_service.db.id
      type = "service"
    }
  }
}