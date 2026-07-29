# Project 01 – Build My First Production Linux Server

## Project Overview

In this project, I built my first Linux server on Amazon EC2. The objective was to understand **why** each configuration exists and how a Linux administrator prepares a new server.

The server was created for an imaginary company called **Lunaria Systems**.

---

## Project Goal

Build a secure Red Hat Enterprise Linux server that administrators can access remotely using SSH.

---

## Technologies Used

* Amazon Web Services (AWS)
* Amazon EC2
* Red Hat Enterprise Linux (RHEL)
* SSH
* GitHub

---

## Infrastructure Choices

### Compute Service

**Amazon EC2**

Reason:

* Provides a virtual Linux server.
* Can be started, stopped, or terminated when needed.
* Supports both vertical and horizontal scaling.
* Suitable for hosting applications and services.

---

### Operating System

**Red Hat Enterprise Linux (RHEL)**

Reason:

* Familiar operating system from RHCSA studies.
* Widely used in enterprise environments.

---

### Instance Type

**t3.micro (Free Tier Eligible)**

Reason:

* Suitable for learning.
* Eligible for AWS Free Tier.

---

### Authentication

**SSH Key Pair**

A key pair was created instead of using passwords.

Reason:

* More secure than password authentication.
* Uses public-key cryptography.

---

### Network Security

A Security Group was configured with the following rule:

| Protocol | Port | Source | Purpose                                         |
| -------- | ---- | ------ | ----------------------------------------------- |
| SSH      | 22   | My IP  | Allow only my computer to administer the server |

Reason:

* Prevents random computers on the Internet from attempting SSH connections.
* Only my current public IP address is allowed.

---

## Tags

The instance was tagged to identify it.

Example:

| Key     | Value                  |
| ------- | ---------------------- |
| Name    | lunaria-prod-server-01 |
| Project | Lunaria                |

---

## Connecting to the Server

After launching the EC2 instance, I connected securely using SSH from Git Bash.

General command format:

```bash
ssh -i "<sample-key>.pem" ec2-user@<PUBLIC-IP>
```

---

## What I Learned

During this project I learned:

* Why EC2 is used instead of S3.
* What an AMI is.
* Why key pairs are more secure than passwords.
* Why SSH should be restricted to "My IP".
* The difference between public and private IP addresses.
* The purpose of Security Groups.
* How to connect securely to a Linux server using SSH.

---

## Screenshots

* EC2 instance overview
* Tags
* Security Group inbound rules
* Successful SSH connection

---

## Current Status

Project is currently in progress.

Completed:

* AWS infrastructure creation
* Secure SSH connectivity

Next steps:

* Inspect the Linux server.
* Create administrator accounts.
* Configure sudo access.
* Verify hostname, CPU, RAM, storage, and networking.
* Automate the infrastructure using Terraform.

