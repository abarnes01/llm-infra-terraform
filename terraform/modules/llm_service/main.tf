terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Build the Docker image from the local Dockerfile
resource "docker_image" "app" {
  name = "${var.image_name}:latest"

  build {
    context    = var.build_context
    dockerfile = var.dockerfile
    # no_cache = true  # uncomment if you want fresh builds each time
  }
}

# Run the container from the built image
resource "docker_container" "app" {
  name  = var.container_name
  image = docker_image.app.image_id

  # Map host:container ports
  ports {
    internal = var.container_port
    external = var.host_port
  }

  # Set env vars for the app to read
  env = [
    "MODEL_NAME=${var.model_name}",
    "RESPONSE_TEMPERATURE=${var.temperature}",
    "PORT=${var.container_port}",
  ]

  restart = var.restart_policy
}
