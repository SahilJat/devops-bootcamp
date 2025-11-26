variable "container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "terraform-web-server"
}

variable "external_port" {
  description = "The public port for Nginx"
  type        = number
  default     = 8080
}
