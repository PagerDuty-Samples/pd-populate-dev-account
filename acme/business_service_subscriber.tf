#CEO knows about IT proublems 
resource "pagerduty_business_service_subscriber" "ceo" {
  subscriber_id = pagerduty_user.business_ceo.id
  subscriber_type = "user"
  business_service_id = pagerduty_business_service.IT.id
}

#helpdesk knows about IT proublems
resource "pagerduty_business_service_subscriber" "helpdesk_example_a" {
  subscriber_id = pagerduty_team.helpdesk_team_a.id
  subscriber_type = "team"
  business_service_id = pagerduty_business_service.IT.id
}

resource "pagerduty_business_service_subscriber" "helpdesk_example_b" {
  subscriber_id = pagerduty_team.helpdesk_team_b.id
  subscriber_type = "team"
  business_service_id = pagerduty_business_service.IT.id
}


#Sales Manger knows about sales impacting proublems
resource "pagerduty_business_service_subscriber" "sales" {
  subscriber_id = pagerduty_user.business_salesManager.id
  subscriber_type = "user"
  business_service_id = pagerduty_business_service.Sales.id
}

#foreman knows about manifacturing probulems
resource "pagerduty_business_service_subscriber" "manifacturing" {
  subscriber_id = pagerduty_user.business_salesManager.id
  subscriber_type = "user"
  business_service_id = pagerduty_business_service.Manifacturing.id
}
