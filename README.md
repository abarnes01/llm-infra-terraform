# LLM Infra with Terraform + Docker

This project demonstrates **Infrastructure as Code (IaC)** with **Terraform** and **Docker** by deploying a lightweight, containerized API that simulates an **LLM inference service**.

The goal is to practice:
- **Docker** for containerization
- **Terraform** for declarative infra automation
- **Reusable modules** with configurable inputs/outputs

It’s intentionally small (~10 hours of work) but structured like a real-world infra project you’d see in interviews or on the job.

---

## Project Structure

llm-infra-terraform/
│
├── docker/
│   ├── Dockerfile        # Builds the FastAPI service image
│   └── app/main.py       # Tiny LLM-like API
│
├── terraform/
│   ├── main.tf           # Root config: calls the module
│   ├── modules/
│   │   └── llm_service/
│   │       ├── main.tf   # Module: builds + runs container
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── terraform.tfvars  # (optional) place overrides here
│
└── README.md

---

## Prerequisites

Before running this project, ensure you have installed:

- Docker Desktop or Docker Engine  
  docker --version
- Terraform CLI (>= 1.5)  
  terraform -version
- Git  
  git --version

Make sure **Docker is running** before using Terraform.

---

## Quickstart

1. Clone the repo:

   git clone <your-repo-url>
   cd llm-infra-terraform/terraform

2. Initialize Terraform (downloads providers):

   terraform init

3. Apply the config to build/run the container:

   terraform apply -auto-approve

4. Check the service is running:

   terraform output endpoint

   Example:
   http://localhost:8000

5. Test the API:

   Health check:
   curl "$(terraform output -raw endpoint)/health"

   Inference:
   curl -X POST "$(terraform output -raw endpoint)/infer" \
     -H "Content-Type: application/json" \
     -d '{"prompt":"deploy llm infra with terraform and docker"}'

6. Tear down (stop + remove container/image):

   terraform destroy -auto-approve

---

## Customization

You can customize deployment using variables.  

Open terraform/main.tf or create a terraform.tfvars file.

Available variables:

| Variable          | Type   | Default          | Description                               |
|-------------------|--------|-----------------|-------------------------------------------|
| image_name        | string | "llm-demo"      | Name of the Docker image                  |
| container_name    | string | "llm-service"   | Name of the Docker container              |
| host_port         | number | 8000            | Host port to expose locally               |
| container_port    | number | 8000            | Port inside the container                 |
| model_name        | string | "llama-3.1-tiny"| Fake model name to advertise             |
| temperature       | number | 0.7             | Response randomness (0–1)                 |
| restart_policy    | string | "unless-stopped"| Docker restart policy                     |

Example override (terraform.tfvars):

model_name   = "mistral-mini"
temperature  = 0.3
host_port    = 9000

Then re-run:

terraform apply -auto-approve

---

## Example Outputs

- Health endpoint:
  {"status":"ok","model":"mistral-mini","temperature":0.3}

- Inference endpoint:
  {
    "model":"mistral-mini",
    "input_tokens":4,
    "output":"docker terraform with deploy 🤖"
  }

---

## Maintenance Commands

- Reformat configs:
  terraform fmt
- Validate configs:
  terraform validate
- Preview changes:
  terraform plan

---

## Extension Ideas (Future Improvements)

If you come back later and want to extend this project:

- **Multiple replicas**: Run several containers with different `model_name`s using `count`.
- **Reverse proxy**: Add Nginx or Traefik container in front of services.
- **Persistent volumes**: Mount a host directory for “model weights” to simulate real LLM storage.
- **CI/CD**: GitHub Actions that run `terraform fmt -check` + `docker build` on PRs.
- **Swap FastAPI app**: Replace with a real local LLM runner (e.g., Ollama).
- **Cloud upgrade**: Replace Docker provider with AWS provider to launch EC2 instances + Docker.

## Clean Up Reminder

If you extend this project to AWS in the future, **always run terraform destroy** to avoid cloud charges.
