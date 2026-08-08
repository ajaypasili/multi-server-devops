# Multi-Server Node Deployment, Reverse Proxy & Automation

# Note: I do not currently have a Hetzner account, so I have not had the opportunity to perform a hands-on deployment on that platform. However, I am familiar with the general process, including provisioning a Hetzner # Cloud server, configuring SSH access and firewall rules, deploying applications, and setting up backups.

# For this project, I selected AWS as I already have access to the platform and wanted to demonstrate a multi-region architecture using AWS services. I also took cost efficiency into consideration and therefore implemented a lightweight AWS setup using only the services required to meet the project objectives.

## Architecture

This project demonstrates a multi-region AWS infrastructure.

### Primary Server

AWS EC2 - Frankfurt
Region:
eu-central-1
Responsibilities:

- Node.js application
- Docker
- Docker Compose
- Nginx reverse proxy
- HTTPS
- GitHub Actions deployment
- Automated backup creation

### Backup Server

AWS EC2 - Mumbai
Region:
ap-south-1

Responsibilities:
- Receive application backups
- Store compressed backup files

---

## Application Architecture

Internet
    |
    v
Nginx
Port 80 / 443
    |
    v
Node.js
Port 3000
    |
    v
Application

Port 3000 is not publicly exposed.

---

## Technologies

- AWS EC2
- Docker
- Docker Compose
- Node.js
- Nginx
- Let's Encrypt
- GitHub Actions
- Git
- UFW
- SSH
- rsync
- Bash
- cron

---

## Docker

The application uses a multi-stage Dockerfile.

The application container listens on port 3000.

Nginx acts as the reverse proxy.

Only ports 22, 80 and 443 are publicly accessible.

---

## CI/CD

GitHub Actions is triggered whenever code is pushed to the main branch.

Pipeline:

1. Checkout source code
2. Build Docker image
3. SSH into Europe EC2
4. Pull latest source code
5. Build Docker containers
6. Restart the application
7. Remove unused Docker images

---

## Security

### Firewall

The primary server allows:
- SSH - 22
- HTTP - 80
- HTTPS - 443
The application port 3000 is not exposed publicly.

### SSH

A dedicated devops user is used.
Password authentication is disabled.
Root SSH login is disabled.
SSH keys are used for authentication.

---

## Backup

The backup script:

1. Creates a timestamped tar.gz archive
2. Stores the backup locally
3. Transfers the backup using rsync over SSH
4. Sends the backup to the Mumbai backup server
5. Removes local backups older than 7 days

---

## Cron

The backup script runs automatically once per day.
Example:
0 2 * * * /opt/multi-server-devops/backup.sh >> /var/log/backup.log 2>&1

---

## Domain

Domain:
ajaydevopsassignment.duckdns.org/

The domain points to the Europe primary server.

---

## HTTPS

Let's Encrypt is used to provide a trusted SSL certificate.

The application is accessible through:

https://ajaydevopsassignment.duckdns.org/

---

## Deployment

The application is automatically deployed when changes are pushed to main.
Example:

git add .

git commit -m "Deploy application"

git push origin main
