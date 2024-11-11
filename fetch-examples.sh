#!/bin/bash

# Variables
REPO="apicurio-registry"
BRANCH="main"  # Change this if you need a different branch
DEST_DIR="external/examples"
TMP_DIR="/tmp/apicurio_examples"

# Delete existing examples
rm -rf "DEST_DIR"

# Create temp directory
mkdir -p "$TMP_DIR"

# Download the `examples` directory as an archive
echo "Downloading examples directory..."
curl -L "https://github.com/Apicurio/$REPO/archive/refs/heads/$BRANCH.zip" -o "$TMP_DIR/repo.zip"

# Extract only the examples directory from the archive
echo "Extracting examples directory..."
unzip "$TMP_DIR/repo.zip"  -d "$TMP_DIR"

# Move extracted examples to the destination directory within your repo

mv "$TMP_DIR/$REPO-$BRANCH/examples" "$DEST_DIR"

# Cleanup
echo "Cleaning up temporary files..."
#rm -rf "$TMP_DIR"

echo "Download complete. Files are in $DEST_DIR."

find . -name "pom.xml" -exec sed -i.bak 's/<version>3.0.4-SNAPSHOT<\/version>/<version>3.0.3<\/version>/g' {} +