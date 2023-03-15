resource "pagerduty_business_service_subscriber" "team_example" {
  subscriber_id = pagerduty_user.business_ceo.id
  subscriber_type = "user"
  business_service_id = pagerduty_business_service.IT.id
}