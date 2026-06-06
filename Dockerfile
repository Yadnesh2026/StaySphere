# Use an image that already has Node.js version 22 installed
FROM node:22

# Create a folder named /app inside the container
# and make it the current working directory
WORKDIR /app

# Copy package.json and package-lock.json
# from your project into the container
COPY package*.json ./

# Install all dependencies mentioned in package.json
RUN npm install

# Copy all remaining project files
# (app.js, routes, models, views, etc.)
COPY . .

# Tell Docker that the application
# will listen on port 8011
EXPOSE 8011

# When the container starts,
# run "node app.js"
CMD ["node","app.js"]


# All Steps include step by step as :

# 1. Download Node.js image
# 2. Create /app folder
# 3. Copy package.json
# 4. Run npm install
# 5. Copy all project files
# 6. Open port 8011
# 7. Run node app.js

# ================================================================================

# DEVOPS WORKFLOW NOTES

# ================================================================================

# ----------------------------

# A. DOCKER

# docker build -t staysphere .                                 # Read Dockerfile and create Docker Image

# docker images                                                # Show all Docker Images

# docker run -p 8011:8011 staysphere                           # Create and start Container from Image

# docker ps                                                    # Show running Containers

# docker stop <container-id>                                   # Stop running Container

# docker login                                                 # Login to Docker Hub

# docker tag staysphere:latest vedantv0502/staysphere:v1       # Create Docker Hub compatible Image

# docker push vedantv0502/staysphere:v1                        # Upload Image to Docker Hub

# docker pull vedantv0502/staysphere:v1                        # Download Image from Docker Hub

# ----------------------------

# B. KUBERNETES

# minikube start                                               # Start local Kubernetes Cluster

# minikube status                                              # Check Minikube Status

# kubectl get nodes                                            # Show Kubernetes Nodes

# kubectl apply -f deployment.yaml                             # Create Deployment from YAML

# kubectl get deployments                                      # Show all Deployments

# kubectl get pods                                             # Show all Running Pods

# kubectl describe pod <pod-name>                              # Show complete Pod Details

# kubectl logs <pod-name>                                      # Show Pod Logs

# kubectl delete pod <pod-name>                                # Delete Pod (Deployment recreates it)

# kubectl get pods -w                                          # Watch Pod changes live

# ----------------------------

# C. SERVICE

# kubectl apply -f service.yaml                                # Create Service

# kubectl get services                                         # Show all Services

# minikube service staysphere-service                          # Open Application through Service

# Flow:

# User -> Service -> Pod -> Container

# ----------------------------

# D. INGRESS

# minikube addons enable ingress                               # Install NGINX Ingress Controller

# kubectl apply -f ingress.yaml                                # Create Ingress Rules

# kubectl get ingress                                          # Show Ingress Information

# kubectl describe ingress staysphere-ingress                  # Show Ingress Details

# Flow:

# User -> Ingress -> Service -> Pod -> Container

# ----------------------------

# E. GIT

# git status                                                   # Show changed files

# git add .                                                    # Add files for commit

# git commit -m "message"                                      # Save changes locally

# git push                                                     # Upload code to GitHub

# git branch                                                   # Show current branch

# git remote -v                                                # Show connected GitHub Repository

# ----------------------------

# F. CI (GitHub Actions)

# Create:

# .github/workflows/docker.yml                               # GitHub Actions Workflow File

# GitHub Secrets:

# DOCKER_USERNAME                                            # Docker Hub Username

# DOCKER_TOKEN                                               # Docker Hub Personal Access Token

# Flow:

# git push

# ↓

# GitHub Actions

# ↓

# Docker Build

# ↓

# Docker Push

# ----------------------------

# G. CD (Current Learning)

# kubectl rollout restart deployment/staysphere-deployment

# Restart Deployment and create New Pod

# New Pod

# ↓

# Pull Latest Docker Image

# ↓

# Old Pod Removed

# ----------------------------

# H. AUTOMATIC CD (Self Hosted Runner)

# Problem:

# GitHub cannot directly access my local Minikube.

# Solution:

# Create a Self Hosted Runner on my laptop.

# Step 1:

# Create actions-runner folder

# Step 2:

# Download GitHub Runner

# Step 3:

# Extract Runner Files

# Step 4:

# .\config.cmd                      # Register my laptop with GitHub

# Step 5:

# .\run.cmd                         # Start Runner

# Output:

# Listening for Jobs

# Meaning:

# GitHub can now execute commands on my laptop.

# ----------------------------

# CD Workflow

# Write Code

# ↓

# git add .

# ↓

# git commit

# ↓

# git push

# ↓

# GitHub Actions (CI)

# ↓

# Docker Build

# ↓

# Docker Hub Push

# ↓

# Self Hosted Runner

# ↓

# kubectl rollout restart deployment/staysphere-deployment

# ↓

# Kubernetes creates New Pod

# ↓

# New Pod pulls latest Docker Image

# ↓

# Old Pod removed

# ↓

# Latest StaySphere running

# ----------------------------

# docker.yml

# build-and-push job

# Purpose:

# Build Docker Image and Push to Docker Hub

# deploy job

# Purpose:

# Use Self Hosted Runner and Restart Kubernetes Deployment

# needs: build-and-push

# Wait for Docker Build to complete

# runs-on: self-hosted

# Use my Laptop instead of GitHub Server

# kubectl rollout restart deployment/staysphere-deployment

# Restart Deployment and deploy latest version

# ----------------------------


# H. COMPLETE DEVOPS FLOW

# Write Code

# ↓

# git add .

# ↓

# git commit

# ↓

# git push

# ↓

# GitHub Actions

# ↓

# Docker Build

# ↓

# Docker Hub

# ↓

# Kubernetes

# ↓

# Deployment

# ↓

# Service

# ↓

# Ingress

# ↓

# User Accesses Application

# ----------------------------

# I. NEXT TOPICS

# ConfigMaps

# Secrets

# Full CD Automation

# Prometheus

# Grafana

# AWS

# EKS

# Terraform

# ================================================================================



#----------------------------
# Why?

# Current CI Flow:

# GitHub Actions
#       ↓
# Docker Hub

# works because Docker Hub is public on the internet.

# But:

# GitHub Actions
#       ↓
# Your Local Minikube

# usually won't work because GitHub cannot reach your laptop.



# This Is Why Companies Use
# AWS EKS
# Azure AKS
# Google GKE

# because those clusters are online.

# GitHub can talk to them.
#----------------------------
