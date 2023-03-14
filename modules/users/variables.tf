variable "email" {
  type        = string
  description = "PagerDuty Users Email Address"
}

variable "name" {
  type        = string
  description = "PagerDuty Users Name"
}

#defaults to limited_users, can be overwritten
variable "role" {
  type        = string
  description = "PagerDuty Users Role"
  default = "limited_user"
}


variable "job_title" {
  type        = string
  description = "PagerDuty Users Job Title"
  default = "Assistant to the Regional Manager"
}

#https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
variable "time_zone" {
  type        = string
  description = "PagerDuty Users TimeZone"
  default = "Europe/London"
}


