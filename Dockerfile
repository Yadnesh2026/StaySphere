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

#---------------------------------------------------------------------------------
# All DevOps Steps

#A . Container the project in Docker 

# 1. after making Docker file then after put them inside the docker as imae 
# docker build -t staysphere . - reads the dockerfile
# without -t (tag) docker creates the image with the long name without out custome name 

# 2.Now create the a running container from the image
# docker run -p 8011:8011 staysphere - creates the container on map the port on 8011

# 3. Docker Hub 
# For making another same image in for docker hub
# docker tag staysphere:latest vedantv/staysphere:v1

#----------------------------
#B. Kubernetes - Make an File name k8s 

# 4. Make an File name k8s
# deployment.yaml - In that make an deployment.yaml file which
# service.yaml - After deployment , To run the app from docker 

# 5. minikube service staysphere-service - To start the App in docker imaage

# 6. Ingress.yaml - Make  another file for ingress as to where to redirect thsi page or wesbite

#----------------------------
#C. CI/CD Pipleline
# 7. dockerr.yaml - make an fil
# 8. kubectl rollout restart deployment/staysphere-deployment - to restart and make new pod





#---------------------------------------------------------------------------------------


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
