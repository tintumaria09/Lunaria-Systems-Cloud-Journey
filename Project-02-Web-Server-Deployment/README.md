# Project 02 – Web Server Deployment

## Project Overview

In this project, I configured a Linux EC2 server as a web server and then automated the configuration using **Ansible**.

The objective was to understand how a Linux administrator can first investigate and configure a server manually, and then translate those steps into repeatable automation.

The server was part of the imaginary company environment **Lunaria Systems**.

This project was completed in two phases:

* **Manual configuration** to understand the server's existing state and the steps required to deploy a web server.
* **Ansible automation** to reproduce the configuration consistently.

The AWS infrastructure used in this project was created in **Project 01**. Terraform was therefore **not recreated in Project 02**. Project 01 focused on infrastructure provisioning, while this project focuses on **Linux server configuration and application deployment using Ansible**.

---

## Project Goal

Configure an existing Linux EC2 server as a web server and automate the configuration using Ansible.

The project demonstrates the progression from:

**Manual server administration → Configuration management → Automated deployment**

---

## Technologies Used

* Amazon Web Services (AWS)
* Amazon EC2
* Red Hat Enterprise Linux (RHEL)
* Apache HTTP Server (`httpd`)
* SSH
* Ansible
* Windows Subsystem for Linux (WSL)
* Git
* GitHub

---

## Infrastructure

The EC2 server used in this project was provisioned during **Project 01**.

The existing infrastructure included:

* Amazon EC2
* Red Hat Enterprise Linux
* Security Group
* SSH key-based authentication
* Network connectivity

No new Terraform infrastructure was created for this project.

This separation demonstrates two different stages of infrastructure management:

| Project    | Tool      | Responsibility                                        |
| ---------- | --------- | ----------------------------------------------------- |
| Project 01 | Terraform | Provision cloud infrastructure                        |
| Project 02 | Ansible   | Configure the Linux server and deploy the web service |

---

# Phase 1 – Manual Server Configuration

Before automating the deployment, I manually investigated and configured the Linux server.

The purpose of this phase was to understand the actual administrative tasks involved before converting them into Ansible automation.

---

## Connecting to the Linux Server

I first connected to the EC2 instance using SSH and verified that I was working on the correct server.

The server identity and environment were checked before making configuration changes.

---

## Checking the Existing Web Server State

Before installing Apache, I checked whether the `httpd` package was already installed.

Command used:

```bash
rpm -q httpd
```

This helped determine the current state of the server before making changes.

This follows an important administration principle:

> **Inspect the current state before changing the system.**

---

## Installing Apache

After determining that the required web server package was not already available in the expected state, I installed Apache HTTP Server (`httpd`).

The Apache web server provides the functionality required to serve web pages from the Linux server.

---

## Investigating Apache Configuration

After installing Apache, I investigated the Apache configuration and related files.

One of the locations examined during the process was:

```text
/etc/httpd/conf.d/welcome.conf
```

This helped me understand where Apache configuration files are stored and how the web server's default configuration is organized.

---

## Manual Verification

After configuring Apache manually, I verified that the web server was functioning correctly.

This manual phase provided the foundation for the automation phase because I now understood:

* What package needed to be installed.
* What service needed to be running.
* What configuration needed to exist.
* Where Apache configuration files were located.
* What needed to be verified after deployment.

---

# Phase 2 – Ansible Automation

After completing the manual configuration, I automated the same process using Ansible.

The purpose was to replace a sequence of manual administrative commands with a repeatable configuration.

---

## Ansible Environment

Ansible was installed and executed from **WSL**, which acted as the Ansible control environment.

Ansible connects to the remote Linux server using SSH.

The overall workflow was:

```text
WSL / Ansible Controller
          │
          │ SSH
          ▼
     Amazon EC2
     Linux Server
          │
          ▼
     Apache Web Server
```

---

## Ansible Inventory

The inventory defines the hosts managed by Ansible and provides the connection information required to access them.

The project contains:

```text
ansible/
├── inventory
├── inventory.example
└── webserver.yml
```

The actual `inventory` file contains environment-specific information and is **not committed to GitHub**.

A sanitized `inventory.example` file is included to demonstrate the expected structure without exposing environment-specific information.

Example:

```ini
[web]
<EC2_PUBLIC_IP> ansible_user=ec2-user ansible_ssh_private_key_file=<PATH_TO_SSH_PRIVATE_KEY>
```

The actual server IP address and private-key path are kept in the local environment.

---

## Ansible Playbook

The main automation file is:

```text
webserver.yml
```

The playbook automates the web server configuration.

The tasks include:

* Installing the Apache (`httpd`) package.
* Ensuring the Apache service is running.
* Enabling the service.
* Creating the website index page.
* Deploying the website content.

This allows the server configuration to be reproduced without manually entering every command.

---

## Playbook Syntax Validation

Before running the playbook against the server, I checked the playbook syntax.

Command:

```bash
ansible-playbook --syntax-check webserver.yml
```

This helped identify YAML and playbook structure errors before making changes to the remote server.

---

## Testing Ansible Connectivity

Before executing the playbook, I verified that Ansible could communicate with the EC2 server.

Command:

```bash
ansible web -i inventory -m ping
```

A successful response returned:

```text
pong
```

This confirmed that:

* The inventory was correctly configured.
* SSH authentication was working.
* Ansible could reach the managed server.

---

## Running the Playbook

After validating the syntax and confirming connectivity, I executed the Ansible playbook.

Command:

```bash
ansible-playbook -i inventory webserver.yml
```

The playbook completed successfully and performed the required server configuration tasks.

---

## Verification

After the Ansible playbook completed, I verified that the expected web server configuration had been applied successfully.

The deployed web server was checked to confirm that:

* Apache was installed.
* The Apache service was running.
* The website content was deployed.
* The web server responded successfully.

This confirmed that the automated configuration produced the expected result.

---

# Architecture

The complete workflow can be represented as:

```text
                    AWS Infrastructure
                           │
                           │
                     Amazon EC2
                     Linux Server
                           │
                           │ SSH
                           ▼
                  Ansible Controller
                       (WSL)
                           │
                           ▼
                   Ansible Inventory
                           │
                           ▼
                    webserver.yml
                           │
              ┌────────────┼────────────┐
              │            │            │
              ▼            ▼            ▼
           Install      Configure     Deploy
          Apache        Service       Website
              │            │            │
              └────────────┼────────────┘
                           ▼
                    Running Web Server
```

A visual architecture diagram can also be included separately in the project repository.

---

# Security and Version Control

Environment-specific information was separated from the automation code.

The following types of files are excluded from version control:

* Actual Ansible inventory
* SSH private keys
* Terraform state files
* Terraform variable files
* Other environment-specific configuration files

The repository uses a **root-level `.gitignore`** to apply these rules across the projects in the repository.

The actual Ansible inventory is kept locally, while `inventory.example` provides a safe template for understanding the required configuration.

No private SSH keys, passwords, or cloud credentials are stored in the repository.

---

# Screenshots

The project includes screenshots documenting both the manual configuration and the Ansible automation process.

## Manual Configuration

### Server Verification

A screenshot showing the manual connection to the Linux server and verification of the correct server environment.

### Checking Apache Installation

A screenshot showing:

```bash
rpm -q httpd
```

This demonstrates that the existing state of the server was checked before configuration.

### Apache Installation

A screenshot showing the manual installation of the Apache (`httpd`) package.

### Apache Configuration Investigation

A screenshot showing the investigation of the Apache welcome configuration:

```text
/etc/httpd/conf.d/welcome.conf
```

These screenshots document the manual investigation and configuration process that was later converted into automation.

---

## Ansible Automation

### Inventory and Playbook Execution

A screenshot showing the Ansible inventory and the execution of the playbook.

### Successful Automation

A screenshot showing the successful Ansible playbook output after the configuration tasks were completed.

These screenshots demonstrate the transition from manual server administration to automated configuration management.

---

# What I Learned

## Ansible

During this project I learned:

* What configuration management means.
* How Ansible communicates with Linux servers using SSH.
* How Ansible inventories identify managed hosts.
* How Ansible playbooks are structured.
* How Ansible modules perform configuration tasks.
* How to validate playbook syntax.
* How to test connectivity using the Ansible `ping` module.
* How to execute an Ansible playbook.
* How Ansible reports task results.
* Why repeatable and idempotent automation is important.

---

## Linux

I reinforced my understanding of:

* Linux package management.
* Apache HTTP Server (`httpd`).
* Linux services.
* Starting and enabling services.
* Apache configuration files.
* File creation and permissions.
* SSH-based remote administration.
* Investigating the current state of a server before making changes.

---

## AWS

This project reinforced the relationship between:

* Amazon EC2
* Security Groups
* SSH
* Linux server administration
* Configuration management

The project also helped demonstrate why infrastructure provisioning and server configuration can be handled by different tools.

---

## Git & GitHub

I learned:

* How `.gitignore` prevents environment-specific files from being tracked.
* Why real Ansible inventories should not be committed when they contain environment-specific information.
* Why SSH private keys must never be committed.
* How `.example` files can document configuration structure safely.
* How repository-level `.gitignore` rules can protect multiple projects.
* How to inspect Git status before staging and committing changes.
* How to verify that specific files are being ignored using `git check-ignore`.

---

# Project Status

**Status:** Completed ✅

### Completed

* Reused the EC2 infrastructure created in Project 01.
* Connected to the Linux server using SSH.
* Investigated the existing server configuration.
* Checked whether Apache (`httpd`) was installed.
* Manually installed Apache.
* Investigated Apache configuration files.
* Manually verified the web server configuration.
* Installed and configured Ansible.
* Created an Ansible inventory.
* Created a sanitized inventory template.
* Created an Ansible playbook.
* Validated the playbook syntax.
* Tested Ansible connectivity.
* Successfully executed the Ansible playbook.
* Deployed the website content.
* Verified the resulting web server configuration.
* Documented the project.
* Separated environment-specific information from version-controlled files.

---

# Conclusion

This project demonstrated the transition from **manual Linux server administration to automated configuration management using Ansible**.

Project 01 established the underlying AWS infrastructure using Terraform. Project 02 builds on that foundation by using Ansible to configure the existing Linux server and deploy a web service.

The project provided practical experience with:

* Linux server administration
* Apache HTTP Server
* SSH
* Ansible inventories
* Ansible playbooks
* Configuration management
* Service management
* Application deployment
* Git and GitHub
* Basic security and configuration management practices

The resulting workflow is:

```text
Project 01
Terraform
    │
    ▼
Provision AWS Infrastructure
    │
    ▼
Amazon EC2
    │
    ▼
Project 02
Ansible
    │
    ▼
Configure Linux Server
    │
    ▼
Deploy Web Server
    │
    ▼
Verify Application
```

This project forms the second stage of my cloud and DevOps learning journey by demonstrating how infrastructure provisioning and configuration management can work together as part of an automated deployment workflow.
