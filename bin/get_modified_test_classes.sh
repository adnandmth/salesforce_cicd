#!/bin/bash
set -x

# Get the current branch name
BRANCH_NAME="$MASTER_BRANCH_NAME"

# Define the reference to the main branch (update this if your main branch has a different name)
BITBUCKET="$REMOTE_NAME"

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Extract test class names from package.xml and replace commas with spaces
TEST_MEMBERS=$(xmllint --xpath '//*[local-name()="members" and contains(text(), "Test")]/text()' ./manifest/package.xml 2>/dev/null | sed 's/,/ /g' | xargs -n1 printf '"%s" ')

# If no test classes were modified, exit with "pass" to skip deployment
if [ -z "$TEST_MEMBERS" ]; then
    echo "No modified test classes found, passing without deployment."
    echo '{"status": "pass"}'
    exit 0
else
    # Output the modified test classes in JSON-like format
    echo $TEST_MEMBERS
fi
