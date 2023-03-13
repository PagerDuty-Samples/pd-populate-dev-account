#
data "local_file" "input" {
  filename = ".creds" #can be anyfile with your api key in it (don't forget to add it to the .gitignore though)
}

# see https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs
provider "pagerduty" {
  token = data.local_file.input.content #reads in your api key from a file
  #token = "your_api_access_token" #you can use this if you want to use your API token in the providers file
}