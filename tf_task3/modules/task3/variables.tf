variable mem {
  default     = "130"
}
variable ver {
  default     = "python2.7"
}
variable timeout {
  default     = "60"
}
variable start {
  default     = "cron(0 4 ? * MON-FRI *)"
}
variable stop {
  default     = "cron(0 18 ? * MON-FRI *)"
}
