CI/CD Pipeline
The CI/CD pipeline is defined in the azure-kubernetes-setup.yml file. It includes the following steps:
•	Checkout infrastructure code
•	Checkout web application code
•	Login to Azure
•	Set up Docker Buildx
•	Log in to Azure Container Registry (ACR)
•	Build and push Docker image
•	Set up Terraform
•	Initialize Terraform
•	Plan Terraform changes
•	Apply Terraform changes
•	Set up Kubernetes
•	Deploy to AKS using Ansible playbook
•	Clean up evicted pods

Terraform Modules
The Terraform configuration is organized into several modules:
•	acr: Manages Azure Container Registry
•	aks: Manages Azure Kubernetes Service
•	monitoring: Manages Azure Monitor and Log Analytics
•	network: Manages virtual network and subnets
•	resourcegroup: Manages resource groups
•	storage: Manages storage accounts and containers

Ansible Playbooks
The Ansible playbook for deploying Kubernetes resources is defined in deploy-k8s.yml. It includes tasks for generating and applying Kubernetes manifests for various resources such as deployments, services, configmaps, ingress, and more.

Scripts
The cleanup.sh script is used to clean up evicted pods in the Kubernetes cluster.

Environment Variables
The project uses environment-specific variables defined in the following files:
dev/terraform.tfvars
prd/terraform.tfvars
stg/terraform.tfvars
