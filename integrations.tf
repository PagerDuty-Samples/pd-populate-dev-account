# SERVICE INTEGRATION
# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/data-sources/vendor
data "pagerduty_vendor" "cloudwatch" {
  name = "Cloudwatch"
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service_integration
resource "pagerduty_service_integration" "cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  service = pagerduty_service.api.id
  vendor  = data.pagerduty_vendor.cloudwatch.id
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/data-sources/vendor
data "pagerduty_vendor" "datadog" {
  name = "Datadog"
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service_integration
resource "pagerduty_service_integration" "datadog" {
  name    = data.pagerduty_vendor.datadog.name
  service = pagerduty_service.api.id
  vendor  = data.pagerduty_vendor.datadog.id
}