provider "pagerduty" {
  token = "your_access_token"
}

terraform {
  required_providers {
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "2.5.2"
    }
  }
}

/* USERS */
resource "pagerduty_user" "bart" {
  email       = "bart@foo.test"
  name        = "Bart Simpson"
  role        = "limited_user"
  description = "Spikey-haired boy"
  job_title   = "Rascal"
}
resource "pagerduty_user" "lisa" {
  email       = "lisa@foo.test"
  name        = "Lisa Simpson"
  role        = "admin"
  description = "The brains"
  job_title   = "Supreme Thinker"
}


# /* TEAMS */
resource "pagerduty_team" "simpson" {
  name        = "Simpson"
  description = "Team of Simpsons"
}


# /* TEAM MEMBERSHIP */
resource "pagerduty_team_membership" "lisa-member" {
  user_id = pagerduty_user.lisa.id
  team_id = pagerduty_team.simpson.id
  role    = "manager"
}

resource "pagerduty_team_membership" "bart-member" {
  user_id = pagerduty_user.bart.id
  team_id = pagerduty_team.simpson.id
  role    = "responder"
}


# /* escalation policy */
resource "pagerduty_escalation_policy" "ep" {
  name      = "Checkout Service Escalation Policy"
  num_loops = 3
  rule {
    escalation_delay_in_minutes = 30
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.foo.id
    }
  }
}

# /* SCHEDULE */
resource "pagerduty_schedule" "foo" {
  name      = "Checkout Service Schedule"
  time_zone = "America/Los_Angeles"
  
  layer {
    name                         = "Night Shift"
    start                        = "2020-12-07T20:00:00-08:00"
    rotation_virtual_start       = "2020-12-07T17:00:00-08:00"
    rotation_turn_length_seconds = 86400
    users                        = [pagerduty_user.lisa.id, pagerduty_user.bart.id]

    restriction {
      type              = "daily_restriction"
      start_time_of_day = "17:00:00"
      duration_seconds  = 54000
    }
  }
}

# /* SERVICES */
resource "pagerduty_service" "api" {
  name              = "Checkout API"
  escalation_policy = pagerduty_escalation_policy.ep.id
  alert_creation = "create_alerts_and_incidents"
}

resource "pagerduty_service" "db" {
  name              = "Checkout DB"
  escalation_policy = pagerduty_escalation_policy.ep.id
  alert_creation = "create_alerts_and_incidents"
}

/* SERVICE INTEGRATION */
data "pagerduty_vendor" "cloudwatch" {
  name = "Cloudwatch"
}

resource "pagerduty_service_integration" "cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  service = pagerduty_service.api.id
  vendor  = data.pagerduty_vendor.cloudwatch.id
}

data "pagerduty_vendor" "datadog" {
  name = "Datadog"
}

resource "pagerduty_service_integration" "datadog" {
  name    = data.pagerduty_vendor.datadog.name
  service = pagerduty_service.api.id
  vendor  = data.pagerduty_vendor.datadog.id
}

# /* BUSINESS SERVICE */
resource "pagerduty_business_service" "api-business" {
  name = "API Business"
}

/* SERVICE DEPENDENCY */
resource "pagerduty_service_dependency" "api-service-dependency" {
  dependency {
    dependent_service {
      id   = pagerduty_business_service.api-business.id
      type = "business_service"
    }
    supporting_service {
      id   = pagerduty_service.api.id
      type = "service"
    }
  }  
}
resource "pagerduty_service_dependency" "api-db-service-dependency" {
  dependency {
    dependent_service {
      id   = pagerduty_business_service.api-business.id
      type = "business_service"
    }
    supporting_service {
      id   = pagerduty_service.db.id
      type = "service"
    }
  }  
}

/* RULESET */
resource "pagerduty_ruleset" "api-service" {
  name = "API Ruleset"
  team {
    id = pagerduty_team.simpson.id
  }
}

/* RULESET RULES (EVENT RULES) */
resource "pagerduty_ruleset_rule" "health-check" {
  ruleset = pagerduty_ruleset.api-service.id 
  position = 0
  disabled = false
  conditions {
    operator = "and"
    subconditions {
      operator = "contains"
      parameter {
        value = "API Health Check violated API Request Failure"
        path = "payload.summary"
      }
    }
  }
  actions {
    suppress {
      value=true
      threshold_value = 3
      threshold_time_unit = "minutes"
      threshold_time_amount = 10
    }
    route {
      value = pagerduty_service.api.id
    }
  }
}

resource "pagerduty_ruleset_rule" "db-connection" {
  ruleset = pagerduty_ruleset.api-service.id 
  position = 1
  disabled = false
  conditions {
    operator = "and"
    subconditions {
      operator = "contains"
      parameter {
        value = "Error connecting to MySQL"
        path = "payload.summary"
      }
    }
  }
  actions {
    route {
      value = pagerduty_service.db.id
    }
  }
}        

resource "pagerduty_ruleset_rule" "high-request-time" {
  ruleset = pagerduty_ruleset.api-service.id 
  position = 2
  disabled = false
  conditions {
    operator = "and"
    subconditions {
      operator = "contains"
      parameter {
        value = "Request Response Time is High for prod"
        path = "payload.summary"
      }
    }
  }
  actions {
    route {
      value = pagerduty_service.api.id
    }
    annotate {
      value = "Refer to runbook at response.pagerduty.com"
    }
  }
}

resource "pagerduty_ruleset_rule" "mysql-long-running-query" {
  ruleset = pagerduty_ruleset.api-service.id 
  position = 3
  disabled = false
  conditions {
    operator = "and"
    subconditions {
      operator = "contains"
      parameter {
        value = "mysql_long_running_query"
        path = "payload.summary"
      }
    }
  }
  actions {
    route {
      value = pagerduty_service.api.id
    }
    severity {
      value = "info"
    }
  }
}
