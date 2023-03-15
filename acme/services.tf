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
  name                    = "Core IT Services"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.it_core.id
  alert_creation          = "create_alerts_and_incidents"
}


#how about some business services 

resource "pagerduty_business_service" "IT" {
  name             = "IT Services"
  description      = "All IT services at ACME inc."
  point_of_contact = pagerduty_team.helpdesk.name #ask the helpdesk for help with IT services
  team             = pagerduty_team.IT.id
}

resource "pagerduty_business_service" "Manifacturing" {
  name             = "Manifacturing"
  description      = "Systems that Impact Manifacturing"
  point_of_contact = pagerduty_team.helpdesk.name #ask the helpdesk for help with IT services
  team             = pagerduty_team.IT.id
}

resource "pagerduty_business_service" "Sales" {
  name             = "Sales"
  description      = "Systems that Impact Sales"
  point_of_contact = pagerduty_team.helpdesk.name #ask the helpdesk for help with IT services
  team             = pagerduty_team.IT.id
}

#how about some dependencies

#manifacturing relies on mainframes and CRM
resource "pagerduty_service_dependency" "Manifacturing_to_mainframe" {
    dependency {
        dependent_service {
            id = pagerduty_business_service.Manifacturing.id
            type = pagerduty_business_service.Manifacturing.type
        }
        supporting_service {
            id = pagerduty_service.service_mainframe.id
            type = pagerduty_service.service_mainframe.type
        }
    }
}

resource "pagerduty_service_dependency" "Manifacturing_to_CRM" {
    dependency {
        dependent_service {
            id = pagerduty_business_service.Manifacturing.id
            type = pagerduty_business_service.Manifacturing.type
        }
        supporting_service {
            id = pagerduty_service.service_CRM.id
            type = pagerduty_service.service_CRM.type
        }
    }
}


#Sales relies on website and CRM
resource "pagerduty_service_dependency" "sales_to_crm" {
    dependency {
        dependent_service {
            id = pagerduty_business_service.Sales.id
            type = pagerduty_business_service.Sales.type
        }
        supporting_service {
            id = pagerduty_service.service_CRM.id
            type = pagerduty_service.service_CRM.type
        }
    }
}

resource "pagerduty_service_dependency" "sales_to_website" {
    dependency {
        dependent_service {
            id = pagerduty_business_service.Sales.id
            type = pagerduty_business_service.Sales.type
        }
        supporting_service {
            id = pagerduty_service.service_web.id
            type = pagerduty_service.service_web.type
        }
    }
}

#IT relies on all 4 services

resource "pagerduty_service_dependency" "it_to_crm" {
    dependency {
        dependent_service {
            id = pagerduty_business_service.IT.id
            type = pagerduty_business_service.IT.type
        }
        supporting_service {
            id = pagerduty_service.service_CRM.id
            type = pagerduty_service.service_CRM.type
        }
    }
}

resource "pagerduty_service_dependency" "it_to_web" {
    dependency {
        dependent_service {
            id = pagerduty_business_service.IT.id
            type = pagerduty_business_service.IT.type
        }
        supporting_service {
            id = pagerduty_service.service_web.id
            type = pagerduty_service.service_web.type
        }
    }
}

resource "pagerduty_service_dependency" "it_to_mainframe" {
    dependency {
        dependent_service {
            id = pagerduty_business_service.IT.id
            type = pagerduty_business_service.IT.type
        }
        supporting_service {
            id = pagerduty_service.service_mainframe.id
            type = pagerduty_service.service_mainframe.type
        }
    }
}

resource "pagerduty_service_dependency" "it_to_core" {
    dependency {
        dependent_service {
            id = pagerduty_business_service.IT.id
            type = pagerduty_business_service.IT.type
        }
        supporting_service {
            id = pagerduty_service.service_core.id
            type = pagerduty_service.service_core.type
        }
    }
}