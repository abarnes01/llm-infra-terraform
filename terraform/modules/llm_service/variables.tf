variable "image_name" {
  description = "Name for the Docker image (repo/name)."
  type        = string
  default     = "llm-demo"
}

variable "build_context" {
  description = "Docker build context path."
  type        = string
}

variable "dockerfile" {
  description = "Dockerfile path."
  type        = string
}

variable "container_name" {
  description = "Container name."
  type        = string
  default     = "llm-service"
}

variable "host_port" {
  description = "Port on host."
  type        = number
  default     = 8000
}

variable "container_port" {
  description = "Port inside container."
  type        = number
  default     = 8000
}

variable "model_name" {
  description = "Fake model name to advertise."
  type        = string
  default     = "llama-3.1-tiny"
}

variable "temperature" {
  description = "Response temperature (0..1)."
  type        = number
  default     = 0.7
}

variable "restart_policy" {
  description = "Docker restart policy."
  type        = string
  default     = "unless-stopped"
}
