provider "pagerduty" {
  token = "your_access_token"
}

terraform {
  required_providers {
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "2.6.0"
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

resource "pagerduty_service" "unrouted" {
  name              = "Checkout Unrouted"
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

/* EVENT ORCHESTRATION */
resource "pagerduty_event_orchestration" "health-check" {
  name = "Health Check Orchestration"
  team  = pagerduty_team.simpson.id
}

/* EVENT ORCHESTRATION ROUTER */
resource "pagerduty_event_orchestration_router" "health-check" {
  event_orchestration = pagerduty_event_orchestration.health-check.id 
  set {
    id = "start"
    rule {
      label = "API Failed Health Check--Route to API Service"
      condition {
        expression = "event.summary matches part 'API Health Check violated API Request Failure' or event.summary matches part 'Request Response Time is High for prod'"
      }
      actions {
        route_to = pagerduty_service.api.id
      }
    }
    rule {
      label = "DB Failed Health Check--Route to DB Service"
      condition {
        expression = "event.summary matches part 'Error connecting to MySQL' or event.summary matches part 'mysql_long_running_query'"
      }
      actions {
        route_to = pagerduty_service.db.id
      }
    }
  }
  catch_all {
    actions{
      route_to = pagerduty_service.unrouted.id
    }
  }
}
resource "pagerduty_event_orchestration_service" "api" {
  service = pagerduty_service.api.id
  set {
    id = "start"
    rule {
      label = "Suppress API Health Check Failure"
      
      condition {
        expression = "event.summary matches part 'API Health Check violated API Request Failure'"
      }
      actions {
        suspend = 600
      }
    }
    rule {
      label = "Annotate API"
      condition {
        expression = "event.summary matches part 'Request Response Time is High for prod'"
      }
      actions {
        annotate = "This is a great note"
      }
    }
    rule {
      label = "Slow DB Query Sev to Info"
      condition {
        expression = "event.summary matches part 'mysql_long_running_query'"
      }
      actions {
        severity = "info"
      }
    }
  }
  catch_all {
    actions {
      
    }
  }
}

  # actions {
  #   suppress {
  #     value=true
  #     threshold_value = 3
  #     threshold_time_unit = "minutes"
  #     threshold_time_amount = 10
  #   }
    # route {
    #   value = pagerduty_service.api.id
    # }
#   }
# }
