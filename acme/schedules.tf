locals{
    helpdesk_team_a = [pagerduty_user.helpdesk_user01.id, pagerduty_user.helpdesk_user02.id,pagerduty_user.helpdesk_user03.id ]
    helpdesk_team_b = [pagerduty_user.helpdesk_user04.id, pagerduty_user.helpdesk_user05.id, pagerduty_user.helpdesk_user06.id ]
    IT_crm = [pagerduty_user.it_user01.id,pagerduty_user.it_user02.id,pagerduty_user.it_user03.id,pagerduty_user.it_user04.id]
    IT_web = [pagerduty_user.it_user05.id,pagerduty_user.it_user06.id,pagerduty_user.it_user07.id,pagerduty_user.it_user08.id]
    IT_mainframe = [pagerduty_user.it_user09.id,pagerduty_user.it_user10.id,pagerduty_user.it_user11.id,pagerduty_user.it_user12.id]
    IT_core = [pagerduty_user.it_user13.id,pagerduty_user.it_user14.id,pagerduty_user.it_user15.id,pagerduty_user.it_user16.id]
}


resource "pagerduty_schedule" "HelpDesk_Day_Shift" {
  name      = "Helpdesk Day Shift Rotation"
  time_zone = "America/New_York"
  layer {
    name                         = "Day Shift"
    start                        = "2015-11-06T00:08:00-05:00" #starts a 8am EST
    rotation_virtual_start       = "2015-11-06T00:08:00-05:00"
    rotation_turn_length_seconds = 86400
    users                        = local.helpdesk_team_a #this is the locally defined rotation of users defiened at the top of this file it's in an array so we don't need to put one there

    restriction {
      type              = "daily_restriction"
      start_time_of_day = "08:00:00" #at 8am the day shift goes oncall
      duration_seconds  = 43200
    }
  }

  teams = [pagerduty_team.helpdesk_team_a.id]
}

resource "pagerduty_schedule" "HelpDesk_Night_Shift" {
  name      = "Help Desk Night Shift Rotation"
  time_zone = "America/New_York"

  layer {
    name                         = "Night Shift"
    start                        = "2015-11-06T20:00:00-05:00" #starts at 8pm
    rotation_virtual_start       = "2015-11-06T20:00:00-05:00"
    rotation_turn_length_seconds = 86400
    users                        = local.helpdesk_team_b #this is the locally defined rotation of users defiened at the top of this file

    restriction {
      type              = "daily_restriction"
      start_time_of_day = "20:00:00"
      duration_seconds  = 32400
    }
  }

  teams = [pagerduty_team.helpdesk_team_b.id] #this is the team ID
}

resource "pagerduty_schedule" "it_crm" {
  name      = "IT CRM"
  time_zone = "America/New_York"

  layer {
    name                         = "Weekly On-call"
    start                        = "2015-11-06T20:00:00-05:00" #starts at 8pm
    rotation_virtual_start       = "2015-11-06T20:00:00-05:00"
    rotation_turn_length_seconds = 86400
    users                        = local.IT_crm #this is the locally defined rotation of users defiened at the top of this file
  }

  teams = [pagerduty_team.it_crm.id] #this is the team ID
}

resource "pagerduty_schedule" "it_web" {
  name      = "IT web"
  time_zone = "America/New_York"

  layer {
    name                         = "Weekly On-call"
    start                        = "2015-11-06T20:00:00-05:00" #starts at 8pm
    rotation_virtual_start       = "2015-11-06T20:00:00-05:00"
    rotation_turn_length_seconds = 86400
    users                        = local.IT_web #this is the locally defined rotation of users defiened at the top of this file
  }

  teams = [pagerduty_team.it_web.id] #this is the team ID
}

resource "pagerduty_schedule" "it_mainframe" {
  name      = "IT web"
  time_zone = "America/New_York"

  layer {
    name                         = "Weekly On-call"
    start                        = "2015-11-06T20:00:00-05:00" #starts at 8pm
    rotation_virtual_start       = "2015-11-06T20:00:00-05:00"
    rotation_turn_length_seconds = 86400
    users                        = local.IT_mainframe #this is the locally defined rotation of users defiened at the top of this file
  }

  teams = [pagerduty_team.it_web.id] #this is the team ID
}


resource "pagerduty_schedule" "it_core" {
  name      = "IT web"
  time_zone = "America/New_York"

  layer {
    name                         = "Weekly On-call"
    start                        = "2015-11-06T20:00:00-05:00" #starts at 8pm
    rotation_virtual_start       = "2015-11-06T20:00:00-05:00"
    rotation_turn_length_seconds = 86400
    users                        = local.IT_core #this is the locally defined rotation of users defiened at the top of this file
  }

  teams = [pagerduty_team.it_core.id] #this is the team ID
}