terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Uses your local Docker daemon (Docker Desktop/Engine)
provider "docker" {}

module "llm_service" {
  source        = "./modules/llm_service"
  image_name    = "llm-demo"
  build_context = "${path.module}/../docker"
  dockerfile    = "${path.module}/../docker/Dockerfile"

  container_name = "llm-service"
  host_port      = 8000
  container_port = 8000

  model_name  = "mistral-tiny" # try changing these
  temperature = 0.35
}

output "endpoint" {
  value = module.llm_service.endpoint
}
