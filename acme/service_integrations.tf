resource "pagerduty_service_integration" "mainframe_email" {
    name              = "MainFrame Email"
    type              = "generic_email_inbound_integration"
    integration_email = "mainframe@pdt-toddfather.pagerduty.com" #integration_email should end with account domain
    service           = pagerduty_service.service_mainframe.id
    email_incident_creation = "use_rules"
    email_filter_mode       = "and-rules-email"
    email_filter {
        body_mode        = "always"
        body_regex       = null
        subject_mode     = "match"
        subject_regex    = "(CRITICAL*)"
    }
}