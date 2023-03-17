---
layout: page
title: Business Rules For ACME
permalink: /business_resources/
---


To make effective use of their PagerDuty account, ACME has built out some of their core business rules and used PagerDuty to help enforce them

## Using Priorities
In order to effectily use business services and make sure that the right people are aware of issues. The Acme team has enabled and uses priorities in their account.

They have also spent time with their help desk and IT staff to make sure that there is a clear understanding of what a P1 -> P5. This information was setup shortly after their account was created and can't be managed by terraform.

This setup can be referenced though a Terraform data resource so that certain events can automatically trigger high priority incidents if necessary.

```terraform
data "pagerduty_priority" "p1" {
  name = "P1"
}
```


## Keeping users and teams in the know

ACME want to keep their leadership aware of service disruptions. They accomplish this though using a by using the `pagerduty_business_service_subscriber` resource in terraform. This takes a type of [user] or [team] a [business service] and links them together with with a [subscriber_id].


### User Example:
```terraform
resource "pagerduty_business_service_subscriber" "ceo" {
  subscriber_id = pagerduty_user.business_ceo.id
  subscriber_type = "user"
  business_service_id = pagerduty_business_service.IT.id
}
```

### Teams Example:
```terraform
resource "pagerduty_business_service_subscriber" "helpdesk_example_b" {
  subscriber_id = pagerduty_team.helpdesk_team_b.id
  subscriber_type = "team"
  business_service_id = pagerduty_business_service.IT.id
}
```