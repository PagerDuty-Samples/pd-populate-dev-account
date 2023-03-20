terraform {
  required_providers {
    # see https://registry.terraform.io/providers/PagerDuty/pagerduty/2.11.2
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "2.11.2"
    }
  }
}

# this can be anyfile with your api key in it (don't forget to add it to the .gitignore though)
data "local_file" "input" {
  filename = "../.creds" 
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs
provider "pagerduty" {
  token = data.local_file.input.content #reads in your api key from a file
}