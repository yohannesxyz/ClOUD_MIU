variable "region" {
  default = "us-east-1"
}

variable "db_password" {
  description = "Password for RDS admin user"
  type        = string
  sensitive   = true
}
