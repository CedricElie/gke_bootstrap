#!/bin/bash

set -e

# Configuration
PROJECT_ID="ck-learn-gcp-thales"
REGION="us-central1"
REPOSITORY="gke-docker-repo"
IMAGE_NAME="gke-web"
IMAGE_TAG="latest"

# Full registry URL
REGISTRY_URL="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "=========================================="
echo "GKE Web Application - Docker Push Script"
echo "=========================================="
echo ""
echo "Registry URL: ${REGISTRY_URL}"
echo ""

# Step 1: Configure Docker authentication
echo "Step 1: Configuring Docker authentication..."
gcloud auth configure-docker ${REGION}-docker.pkg.dev
echo "✓ Docker authentication configured"
echo ""

# Step 2: Build Docker image
echo "Step 2: Building Docker image..."
docker build -t ${REGISTRY_URL} .
echo "✓ Docker image built successfully"
echo ""

# Step 3: Push to Artifact Registry
echo "Step 3: Pushing image to Artifact Registry..."
docker push ${REGISTRY_URL}
echo "✓ Image pushed successfully to Artifact Registry"
echo ""

echo "=========================================="
echo "✓ All steps completed successfully!"
echo "=========================================="
echo ""
echo "Image is ready to deploy to GKE:"
echo "  Registry URL: ${REGISTRY_URL}"
echo ""
