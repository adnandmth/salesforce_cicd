#!/bin/bash

# Install xmllint (libxml2-utils)
echo "Installing xmllint..."
apt-get update && apt-get install -y libxml2-utils || { echo "Failed to install xmllint"; exit 1; }

# Verify xmllint installation
echo "Verifying xmllint installation..."
xmllint --version || { echo "xmllint is not installed"; exit 1; }

# Install Salesforce CLI
echo "Installing Salesforce CLI..."
npm install @salesforce/cli --global || { echo "Failed to install Salesforce CLI"; exit 1; }
sfdx --version || { echo "Salesforce CLI is not working"; exit 1; }