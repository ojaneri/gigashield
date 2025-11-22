#!/bin/bash

# Prompt user for version number
echo "Enter version number:"
read version

# Add all changes
git add .

# Commit with version message
git commit -m "Release v$version"

# Create git tag
git tag v$version

# Push commits to main branch
git push origin main

# Push tags
git push --tags