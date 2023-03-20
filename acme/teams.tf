resource "pagerduty_team" "helpdesk" {
  name        = "the help desk of ACME inc"
  description = "Product and Engineering"
}

resource "pagerduty_team" "helpdesk_team_a" {
  name        = "Help Desk team A"
  description = "Help Desk team A"
  parent      = pagerduty_team.helpdesk.id
}

resource "pagerduty_team" "helpdesk_team_b" {
  name        = "Help Desk team B"
  description = "Help Desk team B"
  parent      = pagerduty_team.helpdesk.id
}

resource "pagerduty_team" "IT" {
  name        = "the IT of ACME inc"
  description = "IT - stands for I tried to make it work"
}

resource "pagerduty_team" "it_core" {
  name        = "IT core Team"
  description = "IT Core Team"
  parent      = pagerduty_team.IT.id
}

resource "pagerduty_team" "it_mainframe" {
  name        = "IT Mainframe Team"
  description = "das mainframe Team"
  parent      = pagerduty_team.IT.id
}

resource "pagerduty_team" "it_web" {
  name        = "Web"
  description = "Spiders building their nests"
  parent      = pagerduty_team.IT.id
}

resource "pagerduty_team" "it_crm" {
  name        = "IT CRM"
  description = "The CRM team"
  parent      = pagerduty_team.IT.id
}