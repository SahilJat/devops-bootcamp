output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.nginx.id
}

output "app_url" {
  description = "The URL to access the app"
  value       = "http://localhost:${var.external_port}"
}
