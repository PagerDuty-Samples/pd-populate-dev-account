---
layout: page
title: PagerDuty Resources For ACME
permalink: /resources/
---

To make effective use of their PagerDuty account, ACME has built out a number of resources that represent their real-world organization and ecosystem.

## Users

When ACME first opens their PagerDuty account, the first step is to add some users.

ACME will have several types of users who will need different abilities and permissions in the account.

Most of the users will need to respond to incidents by [acknowledging] and [resolving] them. Some of the users will be stakeholders but not responders. The executive team won't be responsible for responding to the incidents that happen, but they want to be informed when incidents happen. ACME's Sales Manager, for example, wants to be updated for the ecommerce site - that impacts the Sales team's work - but isn't concerned about other issues that might be raised on the rest of ACME's web services.

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

** maybe a note about SSO here **

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
This configuration assigns *Ida B. Butler*, ACME's `helpdesk_user01` to `Help Desk Team A` as a `responder`. The metanames of the objects, like `helpdesk_user01`, are self-referential for Terraform, and are meaningful within the scope of the Terraform plans. They won't appear in PagerDuty, but will be helpful for any future updates to Terraform-managed objects.

## Schedules

A [schedule](https://support.pagerduty.com/docs/schedule-basics) in PagerDuty determines who will be notified in the event of an incident. Schedules can be pretty simple, or have more complexity, depending on what a team requires.

All the teams in the ACME account will be configured in the same timezone, "America/New York" for US Eastern time. A PagerDuty account will have a default timezone based on where the account owner is located, but individual schedules can have their own timezones if that is more appropriate for teams in different regions using the same PagerDuty account.

The PagerDuty Terraform provider includes the `pagerduty_schedule` [resource] for creating and managing schedules. Since our Terraform is broken out into multiple example files, the teams are also defined locally so the `schedules.tf` file can be used separately. You can also define users, teams, and schedules in a single Terraform plan and reference the objects directly. 

### Help Desk Schedules
ACME's Help Desk has two schedules: one for the *Day Shift* and one for the *Night Shift*. 

The *Day Shift* schedule is made up of the team members of the *Help Desk Team A* team. 

The requirements for this schedule are:
- The folks in Help Desk Team A will be on call from 8:00 AM US Eastern. 
- The shift rotation is 24 hours - a new person will be on call every day.
- Each day, starting at 8:00 AM, the team oncall will receive notifications. Help Desk Team A will only be on call for 12 hours of the 24-hour shift, 8:00 AM to 8:00 PM. 

```
resource "pagerduty_schedule" "HelpDesk_Day_Shift" {
  name      = "Helpdesk Day Shift Rotation"
  time_zone = "America/New_York"
  layer {
    name                         = "Day Shift"
    start                        = "2015-11-06T00:08:00-05:00" #starts a 8am EST
    rotation_virtual_start       = "2015-11-06T00:08:00-05:00"
    rotation_turn_length_seconds = 86400
    users                        = local.helpdesk_team_a # this is the locally defined rotation of users in this example

    restriction {
      type              = "daily_restriction"
      start_time_of_day = "08:00:00" #at 8am the day shift goes oncall
      duration_seconds  = 43200
    }
  }

  teams = [pagerduty_team.helpdesk_team_a.id]
}
```

The *Night Shift* schedule for Help Desk Team B works in a similar way, but with different timings:
- The folks in Help Desk Team B will be on call from 8:00 **PM** US Eastern, 20:00.
- The shift rotation is 24 hours - a new person will be on call every day.
- Each day, starting at 8:00 PM, the team oncall will receive notifications. Help Desk Team B will be on call for 12 hours of the 24-hour shift, 8:00 PM until 8:00 AM the next day.

These two schedules will be complimentary when they are used in an *Escalation Policy*. They could also be combined using different [layers] of the same schedule. This example divides the two shifts up for flexibility, but having a single schedule with two time-based layers is also useful in many cases. **Add the doc for follow-the-sun example**.

### IT Operations Schedules

ACME's IT Operations teams will have a more common schedule for their on call rotations. ACME has four IT Operations teams, responsible for separate sets of services. Each team will need its own schedule so the team can be notified only for their own incidents. This will help speed up the response process by focuing the notifications for the folks best able to respond to the incident.

One of the IT Operations teams is the *CRM Team*. These folks are responsible for incidents related to ACME's Customer Relationship Management system. Their on call shift requirements are:
- The folks in IT CRM will be on cal from 8:00 PM US Eastern.
- The shift rotation is 7 days - this is a weekly rotation. 
- **Need to look at the start day / shift rotation thing. with the origin date set to 2015 that's too much datemath :)** what day does the shift start on?

```
resource "pagerduty_schedule" "it_crm" {
  name      = "IT CRM"
  time_zone = "America/New_York"

  layer {
    name                         = "Weekly On-call"
    start                        = "2015-11-06T20:00:00-05:00" #starts at 8pm
    rotation_virtual_start       = "2015-11-06T20:00:00-05:00"
    rotation_turn_length_seconds = 604800
    users                        = local.IT_crm # this is the locally defined rotation of users for this example
  }

  teams = [pagerduty_team.it_crm.id] #this is the team ID
}
```

### A Note on Team IDs
When a schedule is created in PagerDuty, the users are included individually. Users can be members of multiple schedules, some with their organization team and some maybe as a virtual team that isn't reflected in the company's org chart. There are `teams` included with the Schedules configurations. These are for object ownership - which team in PagerDuty can modify the schedule, and not who is to be included in the schedule.

### Why Are Team Members Added Directly?
When a new user is added to a PagerDuty team, they might not be ready for on call duties! New users can still see services, incidents, and other PagerDuty objects in the account once their `user` is added, but to be on call, they'll need to be included explicitly!

## Escalation Policies

## Services

## Integrations


