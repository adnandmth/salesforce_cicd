#!/bin/bash

# Create server.key
echo "Creating server.key..."
openssl rsa -passin pass:"$SERVER_PASS_KEY_PASSWORD" -in cert/server.pass.key -out cert/server.key || { echo "Failed to create server.key"; exit 1; }

# Set permissions
chmod 600 cert/server.key

# Authenticate with Salesforce
echo "Authenticating with Salesforce Sandbox..."
sfdx auth:jwt:grant --client-id "$STAGING_CLIENT_ID" -f cert/server.key --username "$STAGING_USERNAME" -r "$STAGING_INSTANCE" -a staging --json || { echo "Staging login failed"; exit 1; }

# Verify login
echo "Verifying Salesforce login..."
sfdx force:org:display --target-org staging || { echo "Salesforce login verification failed"; exit 1; }