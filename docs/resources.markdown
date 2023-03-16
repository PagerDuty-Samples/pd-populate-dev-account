---
layout: page
title: PagerDuty Resources For ACME
permalink: /resources/
---

To make effective use of their PagerDuty account, ACME has built out a number of resources that represent their real-world organization and ecosystem.

## Users

When ACME first opens their PagerDuty account, the first step is to add some users.

ACME will have several types of users who will need different abilities and permissions in the account.

Most of the users will need to respond to incidents by [acknowledging] and [resolving] them. Some of the users will be stakeholders but not responders. The executive team won't be responsible for responding to the incidents that happen, but they want to be informed when incidents happen. 

```
resource "pagerduty_user" "helpdesk_user01" {
  email       = "idab@acme.test"
  name        = "Ida B. Butler"
  role        = "limited_user"
}
```

Users are represented in Terraform by they `pagerduty_user` [resource](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/user). Each user at ACME is configured with their `name`, `email`, and `role` included in their configuration. 

Our user, *Ida B. Butler* will be created in PagerDuty with the `limited_user` role. Ida will be a responder for her team.

*** put pointer to the roles translation table thing here ***

## Teams

Once a user is created in PagerDuty, they should be assigned to a [team]. Teams convey permissions and ownership of various components in PagerDuty.

A PagerDuty team will have ownership of services, workflows, and other objects. Team membership also makes creating and using Schedules easier. Teams are created with the `pagerduty_team` [resource].  **NEED TO FIND THE DOCS ON TEAM HIERARCHY**

```
resource "pagerduty_team" "helpdesk" {
  name        = "the help desk of ACME inc"
  description = "Product and Engineering"
}

resource "pagerduty_team" "helpdesk_team_a" {
  name        = "Help Desk team A"
  description = "Help Desk team A"
  parent      = pagerduty_team.helpdesk.id
}
```

ACME will have several teams, representing the Helpdesk and the IT Operations teams. Users can have various roles as members of teams, and may be [managers] or [responders] depending on what they will be required to do in PagerDuty. 

Users are added to a team with the `pagerduty_team_memebership` [resource]. 
```
resource "pagerduty_team_membership" "team_helpdesk_user_01" {
  user_id = pagerduty_user.helpdesk_user01.id
  team_id = pagerduty_team.helpdesk_team_a.id
  role    = "responder"
}
```
This configuration assigns *Ida B. Butler*, ACME's `helpdesk_user01` to `Help Desk Team A` as a `responder`.


## Schedules



## Escalation Policies

## Services

## Integrations


