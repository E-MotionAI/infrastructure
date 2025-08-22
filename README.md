# 🏗️ Infrastructure Project - Kubernetes Deployment

This repository contains Kubernetes deployment manifests for microservices and external dependencies. It includes:

- **Microservices**:
  - `users-service`
  - `workouts-service`
- **External Dependencies**:
  - MongoDB (deployed using a Helm chart)

## 📌 Prerequisites

Ensure you have the following installed:

- [Kubernetes](https://kubernetes.io/) (Minikube, Kind, or a cloud provider)
- [Helm](https://helm.sh/) (for deploying MongoDB)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Docker](https://www.docker.com/) (for building and pushing images)

---

## 🚀 Deployment Steps

Run the following commands to deploy the entire infrastructure:

```bash
# Clone the repository
git clone https://github.com/your-repo.git
cd infrastructure

# Deploy external dependencies (MongoDB)
cd external-dependencies
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install mongodb -f mongo-db/values.yaml bitnami/mongodb
cd ..

# Create Kubernetes namespace
kubectl create namespace magic-key

# Deploy all microservices
kubectl apply -k . --namespace magic-key

# Verify deployments
kubectl get pods -namespace magic-key

# Deploy specific image version
VERSION=${VERSION:-v1.0.2} envsubst < deployment-manifest.yaml | kubectl apply -f - --namespace magic-key
```

## 📜 Folder Structure

├── external-dependencies  
│   ├── mongo-db  
├── users-service    
├── workouts-service  
├── deploy-all-services.sh  
├── kustomization.yaml  
├── .gitignore  
└── README.md  


