# USERS
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/user
resource "pagerduty_user" "helpdesk_user01" {
  email       = "idab@acme.test"
  name        = "Ida B. Butler"
  role        = "limited_user"
}
resource "pagerduty_user" "helpdesk_user02" {
  email       = "willf@acme.test"
  name        = "William B. Foster"
  role        = "limited_user"
}
resource "pagerduty_user" "helpdesk_user03" {
  email       = "bobbyl@acme.test"
  name        = "Robert M. Lussier"
  role        = "limited_user"
}
resource "pagerduty_user" "helpdesk_user04" {
  email       = "rigoS@acme.test"
  name        = "Rigoberto F. Sanders"
  role        = "limited_user"
}
resource "pagerduty_user" "helpdesk_user05" {
  email       = "albieM@acme.test"
  name        = "Albert R. Miller"
  role        = "limited_user"
}

resource "pagerduty_user" "helpdesk_user06" {
  email       = "hBoi@acme.test"
  name        = "Horatio Hornblower"
  role        = "limited_user"
}




resource "pagerduty_user" "it_user01" {
  email       = "mariamaria@acme.test"
  name        = "Maria C. Detwiler"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user02" {
  email       = "bobD@acme.test"
  name        = "Bobby M. Dube"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user03" {
  email       = "glennM@acme.test"
  name        = "Glenn N. Mickle"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user04" {
  email       = "mm@acme.test"
  name        = "Melinda S. Mitchell"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user05" {
  email       = "joesfinaH@acme.test"
  name        = "Josefina D. Hannah"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user06" {
  email       = "tracyD@acme.test"
  name        = "Tracy D. Delagarza"
  role        = "limited_user"
}

resource "pagerduty_user" "it_user07" {
  email       = "davidM@acme.test"
  name        = "David L. Moore"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user08" {
  email       = "davidM@acme.test"
  name        = "David L. Moore"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user09" {
  email       = "raymondG@acme.test"
  name        = "Raymond E. Gray"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user10" {
  email       = "ede@acme.test"
  name        = "Edwin R. Edmiston"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user11" {
  email       = "jeffp@acme.test"
  name        = "Jeff G. Perry"
  role        = "limited_user"
}

resource "pagerduty_user" "it_user12" {
  email       = "stevenM@acme.test"
  name        = "Jeannine A. Davis"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user13" {
  email       = "deaner@acme.test"
  name        = "Deane E. Rosado"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user14" {
  email       = "chrism@acme.test"
  name        = "Christina W. McCarty"
  role        = "limited_user"
}
resource "pagerduty_user" "it_user15" {
  email       = "paulap@acme.test"
  name        = "Paula Petunia"
  role        = "user"
}

resource "pagerduty_user" "it_user16" {
  email       = "fredf@acme.test"
  name        = "Fred K. Flores"
  role        = "user"
}