#https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
variable "time_zone" {
  type        = string
  description = "Timezone for the Schedule"
  default = "America/New_York"
}

variable "name" {
  type        = string
  description = "PagerDuty Schedule Name"
}

#defaults to limited_users, can be overwritten
variable "layers" {
    type = object({
        name  = string,
        start = string,
        rotation_virtual_start = string,
        rotation_turn_length_seconds = number,
        users = list(string),
        teams = list(string),
        restriction = object({
          type  = string,
          start_time_of_day = string,
          duration_seconds = number
        })
    })
}

