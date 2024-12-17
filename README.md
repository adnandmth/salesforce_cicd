# Salesforce Deployment Pipeline

This repository contains a setup to deploy Salesforce metadata to Sandbox and Production environments using a CI/CD pipeline. It leverages Bitbucket Pipelines for deployment orchestration, manifest-based deployments, and bash scripts for streamlined operations.

## Features

1. Automated CI/CD
Deployment steps are defined in the bitbucket-pipelines.yml file, enabling automated and repeatable deployments.

2. Manifest-Driven Deployment
The repository uses a manifest.xml package file to specify the metadata (classes, triggers, etc.) to deploy.

3. Authentication via Certificate
Provides step-by-step instructions to generate and use a certificate for seamless Salesforce authentication.

4. Custom Bash Scripts
Includes helpful bash scripts to orchestrate deployment and simplify repetitive tasks.

## Getting Started

1. Prerequisites

Ensure you have the following tools installed locally:
	•	Salesforce CLI (sfdx)
	•	OpenSSL (for generating certificates)

2. Certificate Setup for Authentication

Before deployment, a certificate is required for Salesforce authentication. Follow the steps inside "Cert" directory.

## CI/CD Workflow

Bitbucket Pipelines Configuration

The bitbucket-pipelines.yml file defines the steps for deployment. It includes:
1.	Install Dependencies

2.	Authenticate with Salesforce

3.	Deploy Metadata to Target Environment

## Contributing

Contributions are welcome! Please create a new branch for any feature or bug fix, and submit a pull request for review.
