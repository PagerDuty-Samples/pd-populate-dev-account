resource "pagerduty_service" "service_CRM" {
  name                    = "CRM"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.it_crm.id
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service" "service_web" {
  name                    = "Web"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.it_web.id
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service" "service_mainframe" {
  name                    = "Mainframe"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.it_web.id
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service" "service_core" {
  name                    = "Core"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.it_web.id
  alert_creation          = "create_alerts_and_incidents"
}