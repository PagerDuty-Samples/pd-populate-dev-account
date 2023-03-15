# USERS
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/user

# TEAM Assignments
# TBH these are a bit painful as you need to do it 1:1
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/team_membership
resource "pagerduty_user" "helpdesk_user01" {
  email       = "idab@acme.test"
  name        = "Ida B. Butler"
  role        = "limited_user"
}

resource "pagerduty_team_membership" "team_helpdesk_user_01" {
  user_id = pagerduty_user.helpdesk_user01.id
  team_id = pagerduty_team.helpdesk_team_a.id
  role    = "responder"
}


resource "pagerduty_user" "helpdesk_user02" {
  email       = "willf@acme.test"
  name        = "William B. Foster"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_helpdesk_user_02" {
  team_id = pagerduty_team.helpdesk_team_a.id
  user_id = pagerduty_user.helpdesk_user02.id
  role    = "responder"
}


resource "pagerduty_user" "helpdesk_user03" {
  email       = "bobbyl@acme.test"
  name        = "Robert M. Lussier"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_helpdesk_user_03" {
  user_id = pagerduty_user.helpdesk_user03.id
  team_id = pagerduty_team.helpdesk_team_a.id
  role    = "responder"
}
resource "pagerduty_user" "helpdesk_user04" {
  email       = "rigoS@acme.test"
  name        = "Rigoberto F. Sanders"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_helpdesk_user_04" {
  user_id = pagerduty_user.helpdesk_user04.id
  team_id = pagerduty_team.helpdesk_team_b.id
  role    = "responder"
}
resource "pagerduty_user" "helpdesk_user05" {
  email       = "albieM@acme.test"
  name        = "Albert R. Miller"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_helpdesk_user_05" {
  user_id = pagerduty_user.helpdesk_user05.id
  team_id = pagerduty_team.helpdesk_team_b.id
  role    = "responder"
}


resource "pagerduty_user" "helpdesk_user06" {
  email       = "hBoi@acme.test"
  name        = "Horatio Hornblower"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_helpdesk_user_06" {
  user_id = pagerduty_user.helpdesk_user06.id
  team_id = pagerduty_team.helpdesk_team_b.id
  role    = "responder"
}

resource "pagerduty_team_membership" "team_mainframe_helpdeskuser_06" {
  user_id = pagerduty_user.helpdesk_user06.id
  team_id = pagerduty_team.it_mainframe.id
  role    = "observer" #because he is learning
}



resource "pagerduty_user" "it_user01" {
  email       = "mariamaria@acme.test"
  name        = "Maria C. Detwiler"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_crm_it_user01" {
  user_id = pagerduty_user.it_user01.id
  team_id = pagerduty_team.it_crm.id
  role    = "responder"
}

resource "pagerduty_user" "it_user02" {
  email       = "bobD@acme.test"
  name        = "Bobby M. Dube"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_crm_it_user02" {
  user_id = pagerduty_user.it_user02.id
  team_id = pagerduty_team.it_crm.id
  role    = "responder"
}
resource "pagerduty_user" "it_user03" {
  email       = "glennM@acme.test"
  name        = "Glenn N. Mickle"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_crm_it_user03" {
  user_id = pagerduty_user.it_user03.id
  team_id = pagerduty_team.it_crm.id
  role    = "responder"
}
resource "pagerduty_user" "it_user04" {
  email       = "mm@acme.test"
  name        = "Melinda S. Mitchell"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_crm_it_user04" {
  user_id = pagerduty_user.it_user04.id
  team_id = pagerduty_team.it_crm.id
  role    = "responder"
}
resource "pagerduty_user" "it_user05" {
  email       = "joesfinaH@acme.test"
  name        = "Josefina D. Hannah"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_web_it_user05" {
  user_id = pagerduty_user.it_user05.id
  team_id = pagerduty_team.it_web.id
  role    = "responder"
}
resource "pagerduty_user" "it_user06" {
  email       = "tracyD@acme.test"
  name        = "Tracy D. Delagarza"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_web_it_user06" {
  user_id = pagerduty_user.it_user06.id
  team_id = pagerduty_team.it_web.id
  role    = "responder"
}
resource "pagerduty_user" "it_user07" {
  email       = "daveM@acme.test"
  name        = "David L. Moore"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_web_it_user07" {
  user_id = pagerduty_user.it_user07.id
  team_id = pagerduty_team.it_web.id
  role    = "responder"
}
resource "pagerduty_user" "it_user08" {
  email       = "davidM@acme.test"
  name        = "David L. Moore"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_web_it_user08" {
  user_id = pagerduty_user.it_user08.id
  team_id = pagerduty_team.it_web.id
  role    = "responder"
}
resource "pagerduty_user" "it_user09" {
  email       = "raymondG@acme.test"
  name        = "Raymond E. Gray"
  role        = "limited_user"
}

resource "pagerduty_team_membership" "team_mainframe_it_user09" {
  user_id = pagerduty_user.it_user09.id
  team_id = pagerduty_team.it_mainframe.id
  role    = "responder"
}

resource "pagerduty_user" "it_user10" {
  email       = "ede@acme.test"
  name        = "Edwin R. Edmiston"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_mainframe_it_user10" {
  user_id = pagerduty_user.it_user10.id
  team_id = pagerduty_team.it_mainframe.id
  role    = "responder"
}
resource "pagerduty_user" "it_user11" {
  email       = "jeffp@acme.test"
  name        = "Jeff G. Perry"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_mainframe_it_user11" {
  user_id = pagerduty_user.it_user11.id
  team_id = pagerduty_team.it_mainframe.id
  role    = "responder"
}

resource "pagerduty_user" "it_user12" {
  email       = "stevenM@acme.test"
  name        = "Jeannine A. Davis"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_mainframe_it_user12" {
  user_id = pagerduty_user.it_user12.id
  team_id = pagerduty_team.it_mainframe.id
  role    = "responder"
}
resource "pagerduty_user" "it_user13" {
  email       = "deaner@acme.test"
  name        = "Deane E. Rosado"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_core_it_user13" {
  user_id = pagerduty_user.it_user13.id
  team_id = pagerduty_team.it_core.id
  role    = "responder"
}
resource "pagerduty_user" "it_user14" {
  email       = "chrism@acme.test"
  name        = "Christina W. McCarty"
  role        = "limited_user"
}
resource "pagerduty_team_membership" "team_core_it_user14" {
  user_id = pagerduty_user.it_user12.id
  team_id = pagerduty_team.it_core.id
  role    = "responder"
}
resource "pagerduty_user" "it_user15" {
  email       = "paulap@acme.test"
  name        = "Paula Petunia"
  role        = "user"
}
resource "pagerduty_team_membership" "team_crm_it_user15" {
  user_id = pagerduty_user.it_user15.id
  team_id = pagerduty_team.it_crm.id
  role    = "responder"
}
resource "pagerduty_team_membership" "team_core_it_user15" {
  user_id = pagerduty_user.it_user15.id
  team_id = pagerduty_team.it_core.id
  role    = "responder"
}

resource "pagerduty_user" "it_user16" {
  email       = "fredf@acme.test"
  name        = "Fred K. Flores"
  role        = "user"
}
resource "pagerduty_team_membership" "team_core_it_user16" {
  user_id = pagerduty_user.it_user16.id
  team_id = pagerduty_team.it_core.id
  role    = "manager"
}

resource "pagerduty_team_membership" "team_crm_it_user16" {
  user_id = pagerduty_user.it_user16.id
  team_id = pagerduty_team.it_crm.id
  role    = "manager"
}

resource "pagerduty_team_membership" "team_web_it_user16" {
  user_id = pagerduty_user.it_user16.id
  team_id = pagerduty_team.it_web.id
  role    = "manager"
}

resource "pagerduty_team_membership" "team_mainframe_it_user16" {
  user_id = pagerduty_user.it_user16.id
  team_id = pagerduty_team.it_mainframe.id
  role    = "manager"
}