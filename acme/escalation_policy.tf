#team escelation policies
#, pagerduty_team.it_web.id, pagerduty_team.it_mainframe.id, pagerduty_team.it_core.id
resource "pagerduty_escalation_policy" "fred_escelate_policy" {
  name      = "Escalation Policy to Fred"
  num_loops = 1

  rule {
    escalation_delay_in_minutes = 10
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.sucks_to_be_fred.id
    }
  }
}

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

resource "pagerduty_escalation_policy" "it_crm" {
  name      = "IT CRM Policy"
  teams     = [pagerduty_team.it_crm.id]
  num_loops = 1

  rule {
    escalation_delay_in_minutes = 60
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.it_crm.id
    }
  }
  rule {
    escalation_delay_in_minutes = 10 #fred does get a bit of time to respond
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.sucks_to_be_fred.id 
    }
  }
}

resource "pagerduty_escalation_policy" "it_web" {
  name      = "IT Web Policy"
  teams     = [pagerduty_team.it_web.id]
  num_loops = 1

  rule {
    escalation_delay_in_minutes = 60
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.it_web.id
    }
  }
  rule {
    escalation_delay_in_minutes = 10 #fred does get a bit of time to respond
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.sucks_to_be_fred.id 
    }
  }
}


resource "pagerduty_escalation_policy" "it_mainframe" {
  name      = "IT Mainframe Policy"
  teams     = [pagerduty_team.it_mainframe.id]
  num_loops = 1

  rule {
    escalation_delay_in_minutes = 60
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.it_mainframe.id
    }
  }
  rule {
    escalation_delay_in_minutes = 10 #fred does get a bit of time to respond
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.sucks_to_be_fred.id 
    }
  }
}

resource "pagerduty_escalation_policy" "it_core" {
  name      = "IT Core Policy"
  teams     = [pagerduty_team.it_core.id]
  num_loops = 1

  rule {
    escalation_delay_in_minutes = 60
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.it_core.id
    }
  }
  rule {
    escalation_delay_in_minutes = 60 #fred does get a lot of time to respond
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.sucks_to_be_fred.id
    }
  }
}