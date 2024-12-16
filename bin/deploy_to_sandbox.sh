#!/bin/bash
set -x

# Deploy to Salesforce Sandbox with specified test classes or all local tests
echo "Deploying code to Sandbox and running tests..."
echo "$TEST_OUTPUT"

# Sanitize the variable
TEST_OUTPUT=$(echo "$TEST_OUTPUT" | sed 's/"//g')
echo "Sanitized TEST_OUTPUT: [$TEST_OUTPUT]"

if [[ "$TEST_OUTPUT" == *"pass"* ]]; then
    echo "No classes modified; passing without deployment."
    exit 0
else
    echo "Modified Test Classes: $TEST_OUTPUT"
    TEST_LEVEL="RunSpecifiedTests"

    # Deploy using package.xml and run the specified tests
    if ! sfdx project deploy start --manifest ./manifest/package.xml --target-org staging --test-level "$TEST_LEVEL" --tests $TEST_OUTPUT --wait 10 --json --ignore-conflicts; then
        echo "Staging deployment or tests failed"
        exit 1 # Force the script to fail
    fi
fi