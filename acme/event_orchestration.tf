# EVENT ORCHESTRATION
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/event_orchestration
resource "pagerduty_event_orchestration" "health_check" {
  name = "Health Check Orchestration"
  team = pagerduty_team.simpson.id
}

# EVENT ORCHESTRATION ROUTER
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/event_orchestration_router
resource "pagerduty_event_orchestration_router" "health_check" {
  event_orchestration = pagerduty_event_orchestration.health_check.id

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
    actions {
      route_to = pagerduty_service.unrouted.id
    }
  }
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/event_orchestration_service
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