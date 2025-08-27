output "container_id" {
  value = docker_container.app.id
}

output "image_id" {
  value = docker_image.app.image_id
}

output "endpoint" {
  value = "http://localhost:${var.host_port}"
  description = "Base URL for the service."
}
