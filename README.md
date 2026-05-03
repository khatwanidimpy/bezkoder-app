# 🚀 Docker Compose Nodejs, React and Postgres DevOps Example

## Run the System
We can easily run the whole application with a single command:

```bash
docker compose up
```

Docker will pull the required images (PostgreSQL, Node.js, React) if they are not available on your machine.

The services can also be run in the background using:

```bash
docker compose up -d
```

---

## Stop the System
Stopping all running containers is simple:

```bash
docker compose down
```

To stop and remove all containers, networks, and images:

```bash
docker compose down --rmi all
```

---

## 🐳 Services Included

- Frontend: React App (Port: 3000/8081)  
- Backend: Node.js + Express API (Port: 8080)  
- Database: PostgreSQL  

---

## ⚙️ Application Architecture

- React frontend communicates with Node.js backend via REST APIs  
- Backend uses Sequelize ORM to interact with PostgreSQL  
- Docker Compose orchestrates multi-container setup  

---

## 🔄 CI/CD with GitHub Actions

This project includes a CI/CD pipeline using GitHub Actions.

### Workflow Features:
- Runs on push and pull requests  
- Installs dependencies  
- Builds frontend and backend  
- Ready for deployment integration  

📂 Location:
```
.github/workflows/
```

---

## 🏗️ Infrastructure with Terraform

Terraform is used for provisioning infrastructure.

### Run Terraform:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Purpose:
- Automates infrastructure setup  
- Ensures consistent environments  
- Supports scalable deployment  

---

## 🔧 Local Development (Without Docker)

### Backend:

```bash
cd backend
npm install
node server.js
```

### Frontend:

```bash
cd frontend
npm install
npm start
```

---

## 🔌 API Endpoints

- GET /api/tutorials  
- GET /api/tutorials/:id  
- POST /api/tutorials  
- PUT /api/tutorials/:id  
- DELETE /api/tutorials/:id  

---

## 📁 Project Structure

```
bezkoder-app/
│
├── backend/
├── frontend/
│
├── docker-compose.yml
│
├── .github/
│   └── workflows/
│
├── terraform/
│
└── README.md
```

---

## 📘 More Details

For more detail, please visit:

https://www.bezkoder.com/docker-compose-nodejs-postgres/

---

## 🔗 Related Posts

https://www.bezkoder.com/node-express-sequelize-postgresql/  
https://www.bezkoder.com/node-js-pagination-postgresql/  
https://www.bezkoder.com/node-js-csv-postgresql/  
https://www.bezkoder.com/node-js-export-postgresql-csv-file/  
https://www.bezkoder.com/node-js-jwt-authentication-postgresql/  

---

## 🔗 Associations

https://www.bezkoder.com/sequelize-associate-one-to-many/  
https://www.bezkoder.com/sequelize-associate-many-to-many/  

---

## 💡 DevOps Highlights

- Dockerized full-stack application  
- Multi-container orchestration using Docker Compose  
- CI/CD pipeline with GitHub Actions  
- Infrastructure provisioning using Terraform  

---

## 👩‍💻 Author

Dimpy Khatwani  
DevOps Engineer