#
data "local_file" "input" {
  filename = ".creds"
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs
provider "pagerduty" {
  token = data.local_file.input.content #reads in your api key from a file
  #token = "your_api_access_token" #you can use this if you want to use your API token in the providers file
}