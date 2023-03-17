---
layout: page
title: PagerDuty Business
permalink: /business_services/
---


To make effective use of their PagerDuty account, ACME has built a few 

## Business Services

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

## Other Schedules
There are some use cases where a single user is on call continuously. Hopefully, these are for low-priority incidents! Often a single user schedule is helpful for specific types of escalations or specialty services that require restricted access, specific knowledge, or other limited resources.

Fred Flores is the glue that holds much of ACME's IT Operations together. He's been with the company for decades, and built many of the original services. Since Fred is knowledgeable about many services, he's not normally on call for any of the IT sub-teams, but he has his own dedicated schedule just in case he's needed for esoteric incidents, escalations, or emergencies.
```
resource "pagerduty_schedule" "sucks_to_be_fred" {
  name      = "Fred is Always on Call"
  time_zone = "America/New_York"

  layer {
    name                         = "Weekly On-call"
    start                        = "2015-11-06T20:00:00-05:00" # starts at 8pm
    rotation_virtual_start       = "2015-11-06T20:00:00-05:00"
    rotation_turn_length_seconds = 604800
    users                        = [pagerduty_user.it_user16.id] # we are setting the explict user in the list/array
  }
}
```


## Escalation Policies

In PagerDuty, [escalation policies] are how *schedules* get attached to *services*. You can build escalation policies with users or with schedules, but we recommend using schedules to keep updates more streamlined. New users are added to schedules and not to individual escalation policies.

Each service in PagerDuty will have a one (and only one!) escalation policy attached to it, and multiple services can make use of the same escalation policy. So a team's escalation policy can be applied to all of the services a team owns. 

Each escalation policy can be made up of different rules for who to contact when an incident is initiated. Each rule will specify how long PagerDuty should wait for an [acknowledgement] before checking the next rule for another round of notifications. 

The ACME Help Desk has an escalation policy that will make use of both of the Help Desk on call schedules. The first round of notifications will go to whichever Help Desk engineer is on call. Because the schedules have different hours, PagerDuty will only notify one engineer. If the Help Desk doesn't respond, Fred will be paged!

Escalation policies are configured in Terraform using the `pagerduty_escalation_policy` [resource].

```
resource "pagerduty_escalation_policy" "helpdesk" {
  name      = "Page the Helpdesk"
  num_loops = 1

  rule {
    escalation_delay_in_minutes = 30
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.HelpDesk_Day_Shift.id
    }
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.HelpDesk_Night_Shift.id
    }
  }
  #if the helpdesk doesn't answer fred gets paged
  rule {
    escalation_delay_in_minutes = 1 #fred doesn't get very long to respond, fred is a machine
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.sucks_to_be_fred.id #it really sucks to be fred
    }
  }
}
```

Escalation policies can have up to 20 rules for how to notify responders. Each rule has its own `rule` section, made up of one or more `target`s. Targets can be individual users, a selection of several users, a single schedule, or multiple schedules. The entire ruleset can also be looped through 9 times. This is configured with `num_loops`. Once all the notifications are exhausted, the incident will stay assigned to the last notified responder. Between each set of rules is a delay, set with `escalation_delay_in_minutes` which tells PagerDuty how long to wait for a responder to *acknowledge* an incident before trying a responder in the next *rule*. 

**The escalation policy only proceeds through the rules until the incident is acknowledged.** 

### What happens if no one is on call?
The application of schedules and escalation policies can be complex. You'll want to make sure that your services are covered during the hours you intend them to be covered! If an incident occurs while no one is assigned on call for the service, **no notifications will go out** by default. The incidents will be created, but no one on your team will be notfied about them.

This behavior can be changed on a service-by-service basis. It is part of the service configuration itself, and separate from the escalation policy settings. Services can be configured with [defined support hours](https://support.pagerduty.com/docs/dynamic-notifications#defined-support-hours) that will notify responders during support hours and can be set to notify on incidents that come in on off hours when the support hours start again. 

### Other Cases - Round Robin
Another common pattern for Help Desk and NOC-type teams is to make use of [round robin scheduling](https://support.pagerduty.com/docs/round-robin-scheduling). This will change the behavior of the escalation policy rule by assigning incidents to each of the members of a schedule in turn. Unfortunately, this feature is not enabled via the API and is currently unavailable via Terraform. 

## Services

*Services* are how PagerDuty represents pieces of work. Most of the services in a PagerDuty account will represent some kind of technical service - web applications, middleware, databases - but services can also represent [workflows](link to services post). A service can be anything that might need attention, and is wholly owned by a single team.

Since ACME is looking to create specific processes for incident response around their technical services, those are what will be configured first. Each service is created with the `pagerduty_service` [resource]. A service has a unique `name` and an `escalation_policy` from the policies that were created earlier. There are a number of optional configurations as well. ACME will start out with some basic configurations to try out until they determine how well their new procedures are working. 

The two options they've decided on are `auto_resolve_timeout` and `acknowledgement_timeout`:
- `auto_resolve_timeout` will automatically resolve incidents if they are left idle for more than 4 hours. **Is this a good thing to be setting in an example?**
- `acknowledgement_timeout` will re-escalate an incident and begin notifying people if not resolved within 10 minutes. **oh yeah, this is a terrible idea, why would this be in the examples**

```
resource "pagerduty_service" "service_CRM" {
  name                    = "CRM"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.it_crm.id
  alert_creation          = "create_alerts_and_incidents"
}
```

ACME will create services for their *CRM* application, as well as *Web*, *Mainframe*, and *Core IT Services*. These four services will start out as catch-alls for any alerts related to these services and are configured to notify the appropriate teams.

ACME's Core IT Services team also wants to split out some of their alerts to specific services for better tracking and notification of stakeholders. These services are set up the same as the main services, and they are all configured to use the Core Services escalation policy. For example, they have a service for each of *Core DNS Services* and *Core VMware Services*:

```
resource "pagerduty_service" "service_dns" {
  name                    = "Core DNS Services"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.it_core.id
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service" "service_vmware" {
  name                    = "Core VMware Services"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.it_core.id
  alert_creation          = "create_alerts_and_incidents"
}
```
### Business Services

## Integrations

PagerDuty *Integrations* allow PagerDuty services to receive information from outside of PagerDuty. This information can be alerts from monitoring systems, build systems, physical hardware and facilities, or any number of other sources.  PagerDuty can receive alerts from over [700](https://pagerduty.com/integrations) sources using published integrations, and teams can create their own integrations if one isn't available for their system. 

