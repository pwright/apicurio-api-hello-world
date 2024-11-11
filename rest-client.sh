#!/bin/bash

# Set script to exit on any command failure and enable debugging
set -e
set -o pipefail

# Define variables for paths
EXAMPLES_DIR="external/examples"

# Function to print error messages to stderr
log_error() {
    echo "$1" >&2
}

# Check if the example directory is provided as a command-line argument
if [ "$#" -lt 1 ]; then
    log_error "Usage: $0 <example-dir>"
    exit 1
fi

# Get the example directory from command-line arguments
EXAMPLE_NAME="$1"
REST_CLIENT_DIR="$EXAMPLES_DIR/$EXAMPLE_NAME"

# Check if specified example directory exists
if [ ! -d "$REST_CLIENT_DIR" ]; then
    log_error "Specified example directory not found at $REST_CLIENT_DIR"
    exit 1
fi

# Change to the specified example directory
cd "$REST_CLIENT_DIR"

# Prepare the environment (e.g., install dependencies)
log_error "Preparing environment..."
if [ -f "pom.xml" ]; then
    # Assuming Maven is used to build the project
    log_error "Building the project with Maven..."
    mvn clean install -U -Dmaven.repo.local=/tmp/m2/repository || {
        log_error "Failed to build the project. Attempting to resolve parent POM manually..."
        PARENT_POM="../pom.xml"
        if [ -f "$PARENT_POM" ]; then
            log_error "Installing parent POM..."
            mvn install -f "$PARENT_POM" -Dmaven.repo.local=/tmp/m2/repository
            log_error "Retrying project build..."
            mvn clean install -U -Dmaven.repo.local=/tmp/m2/repository
        else
            log_error "Parent POM not found. Cannot proceed."
            exit 1
        fi
    }
else
    log_error "No pom.xml found. Cannot proceed with Maven build."
    exit 1
fi

# Run the specified example
log_error "Running the $EXAMPLE_NAME example..."
# Assuming there's a main class or specific way to run the example
# Modify the command below based on the specifics of the project
mvn exec:java -Dexec.mainClass="com.example.restclient.Main" -Dmaven.repo.local=/tmp/m2/repository

log_error "$EXAMPLE_NAME example run complete."
