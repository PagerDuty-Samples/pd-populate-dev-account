# TEAMS
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/team
resource "pagerduty_team" "simpson" {
  name        = "Simpson"
  description = "Team of Simpsons"
}


# TEAM MEMBERSHIP
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/team_membership
resource "pagerduty_team_membership" "lisa" {
  user_id = pagerduty_user.lisa.id
  team_id = pagerduty_team.simpson.id
  role    = "manager"
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/team_membership
resource "pagerduty_team_membership" "bart" {
  user_id = pagerduty_user.bart.id
  team_id = pagerduty_team.simpson.id
  role    = "responder"
}