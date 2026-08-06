# Project 01 – First Production Cloud Server

## Project Overview

In this project, I built my first Linux server on Amazon EC2. The objective was to understand **why** each configuration exists and how a Linux administrator prepares a new server.

The server was created for an imaginary company called **Lunaria Systems**.

This project was completed in two phases:

* **Manual deployment** using the AWS Management Console to understand each AWS component.
* **Infrastructure as Code (IaC)** using Terraform to automate the deployment.

---

## Project Goal

Build a secure Red Hat Enterprise Linux server that administrators can access remotely using SSH, verify the health of the server after deployment, and automate the infrastructure using Terraform.

---

## Technologies Used

* Amazon Web Services (AWS)
* Amazon EC2
* Red Hat Enterprise Linux (RHEL)
* SSH
* Terraform
* Git
* GitHub

---

## Infrastructure Choices

### Compute Service

**Amazon EC2**

**Reason**

* Provides a virtual Linux server.
* Can be started, stopped, or terminated when needed.
* Supports both vertical and horizontal scaling.
* Suitable for hosting applications and services.

---

### Operating System

**Red Hat Enterprise Linux (RHEL)**

**Reason**

* Familiar operating system from my RHCSA studies.
* Widely used in enterprise environments.

---

### Instance Type

**t3.micro (Free Tier Eligible)**

**Reason**

* Suitable for learning.
* Eligible for AWS Free Tier.

---

### Authentication

**SSH Key Pair**

A key pair was created instead of using passwords.

**Reason**

* More secure than password authentication.
* Uses public-key cryptography.
* Recommended authentication method for Linux server administration.

---

### Network Security

A Security Group was configured with the following rule:

| Protocol | Port | Source | Purpose                                         |
| -------- | ---- | ------ | ----------------------------------------------- |
| SSH      | 22   | My IP  | Allow only my computer to administer the server |

**Reason**

* Prevents random computers on the Internet from attempting SSH connections.
* Restricts remote administration to my current public IP address.

---

## Tags

The instance was tagged to identify it.

Example:

| Key     | Value                  |
| ------- | ---------------------- |
| Name    | lunaria-prod-server-01 |
| Project | Lunaria                |

Resource tags make cloud resources easier to organize, identify, and manage.

---

## Connecting to the Server

After launching the EC2 instance, I connected securely using SSH from Git Bash.

General command format:

```bash
ssh -i "<sample-key>.pem" ec2-user@<PUBLIC-IP>
```

---

## Linux Server Verification

After establishing the SSH connection, I verified that the server was functioning correctly by checking:

* Server identity (`hostname`, `hostnamectl`)
* Memory information (`free`, `free -h`)
* CPU information (`lscpu`)
* Disk usage (`df`, `df -h`)
* Storage layout (`lsblk`)
* Network connectivity (`ping 8.8.8.8`)
* DNS resolution (`ping google.com`)

These verification steps represent the basic health checks commonly performed after provisioning a new Linux server.

---

## Infrastructure as Code (Terraform)

After creating the infrastructure manually, I recreated the same environment using Terraform.

The Terraform project was organized into multiple files:

* `main.tf`
* `variables.tf`
* `.gitignore`
* `.terraform.lock.hcl`

During this phase I learned:

* Terraform providers
* Terraform resources
* Variables
* `terraform init`
* `terraform validate`
* `terraform plan`
* `terraform apply`
* Terraform state
* Why sensitive files such as state files should not be committed to GitHub
---

## What I Learned

During this project I learned:

### AWS

* Why Amazon EC2 is used instead of Amazon S3.
* What an Amazon Machine Image (AMI) is.
* How EC2 instances are launched and managed.
* The purpose of Security Groups.
* The importance of resource tagging.
* The difference between public and private IP addresses.

### Linux

* How to connect securely to a Linux server using SSH.
* How to verify the identity of a Linux server.
* How to inspect memory, CPU, disk usage, and storage layout.
* How to verify Internet connectivity and DNS resolution.

### Terraform

* How Infrastructure as Code simplifies cloud deployments.
* How Terraform providers and resources work.
* How to organize Terraform configuration files.
* The purpose of variables in Terraform.
* Why Terraform state files should not be committed to GitHub.
* How to initialize, validate, plan, and apply Terraform configurations.

### Git & GitHub

* How to clone a Git repository.
* How to organize project files inside a repository.
* How to stage, commit, and push changes.
* The importance of using `.gitignore`.
* How Git commit identity differs from GitHub authentication.

---

## Screenshots

The following screenshots are available in the **screenshots** folder.

### AWS Infrastructure

* 01-ec2-instance-overview
* 02-tags
* 03-security-group-inbound-rules

### Secure Remote Access

* 04-successful-ssh-login

### Linux Server Verification

* 05-server-identity-verification
* 06-memory-information
* 07-cpu-information
* 08-disk-information
* 09-storage-layout
* 10-network-connectivity-and-dns

### Infrastructure as Code

* 11-terraform-ec2-instance
* 12-terraform-security-groups

---

## Project Status

**Status:** Completed ✅

### Completed

* Provisioned an Amazon EC2 instance.
* Configured secure SSH access.
* Restricted administrative access using Security Groups.
* Verified server identity and system health.
* Verified storage, CPU, memory, and networking.
* Verified Internet connectivity and DNS resolution.
* Recreated the infrastructure using Terraform.
* Documented the project using GitHub.

---

## Conclusion

This project provided practical experience in provisioning, securing, verifying, and automating a Linux server on AWS. It established a strong foundation in Linux administration, AWS fundamentals, Infrastructure as Code with Terraform, and version control with Git and GitHub, forming the first project in my cloud and DevOps portfolio.
