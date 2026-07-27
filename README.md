# 🚀 StaySphere — Accommodation Booking Platform

StaySphere is a full-stack accommodation booking platform built using the MERN stack (MongoDB, Express.js, React.js, Node.js). The application allows users to browse property listings, view details, and manage bookings through a responsive and user-friendly interface

---
## 🚀 Features

- 🏠 Browse and view accommodation listings
- 🔍 Detailed property pages
- 👤 User authentication and authorization
- 📦 REST API integration between frontend and backend
- 🎨 Modern responsive UI
- 🧱 MVC architecture implementation
- 📱 Mobile-friendly design

---
## 🛠️ Tech Stack

### Frontend
- React.js
- JavaScript
- HTML5
- CSS3
- Tailwind CSS

### Backend
- Node.js
- Express.js

### Database
- MongoDB

### Tools & Deployment
- Git & GitHub
- REST APIs
- Docker
- Kubernetes (Minikube)
- GitHub Actions (CI/CD)

---

## 🚀 DevOps Implementation

This project has been containerized and automated using modern DevOps practices.

### ✅ Docker
- Dockerized frontend and backend services
- Created custom Docker images
- Managed application dependencies through containers

### ✅ CI/CD Pipeline
- Implemented GitHub Actions workflow
- Automatic build process on code push
- Docker image creation and publishing
- Continuous Integration for reliable deployments

### ✅ Kubernetes
- Deployed application on Kubernetes cluster using Minikube
- Created Deployment and Service YAML configurations
- Managed Pods and ReplicaSets
- Enabled scalable and highly available application deployment

### 🔄 DevOps Workflow

```
Developer
    │
    ▼
Push Code to GitHub
    │
    ▼
GitHub Actions (CI)
    │
    ├── Build Application
    ├── Run Checks
    └── Build Docker Image
    │
    ▼
Push Docker Image to Docker Hub
    │
    ▼
Kubernetes Cluster
    │
    ├── Pull Latest Image
    ├── Create/Update Pods
    └── Expose Application via Service
    │
    ▼
Application Live
```

---

## ⚙️ Installation & Setup

### Clone the repository

```bash
git clone https://github.com/Yadnesh2026/StaySphere.git
```

### Move into project folder

```bash
cd StaySphere
```

### Install dependencies

```bash
npm install
```

### Start development server

```bash
npm run dev
```

---

## 📂 Project Structure

```
StaySphere/
│
├── client/          # Frontend (React)
├── server/          # Backend (Node + Express)
├── models/          # Database models
├── routes/          # API routes
├── controllers/     # MVC controllers
├── Dockerfile       # Docker configuration
├── k8s/             # Kubernetes manifests
└── .github/workflows/ # CI/CD pipeline
```

---

## 🎯 Purpose

This project was developed to practice full-stack development using the MERN stack and to implement real-world booking platform features including authentication, REST API integration, containerization, CI/CD automation, and Kubernetes deployment.

---

## 👨‍💻 Author

**Yadnesh Vidulkar**  
B.Tech Information Technology (Data Science)

---

## ⭐ Future Improvements

- 💳 Online payment integration
- 🔎 Advanced search filters
- ⭐ Reviews & ratings system
- 🛡️ Admin dashboard
- ☁️ Cloud deployment (AWS EKS)
- 📊 Monitoring with Prometheus & Grafana
- 🔔 Centralized logging and alerting
