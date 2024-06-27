#!/bin/bash

# Colors for echo messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Initialize an empty array to hold file names
files_to_add=()

# Loop to ask for file names to add
while true; do
    echo -e "${YELLOW}This does git add, git commit -m "", and git push. For anything more complex, use git directly.${NC}"
    git status
    read -p "Enter path to add (or nothing to finish): " filename
    if [ -z "$filename" ]; then
        break
    fi
    git add "$filename"
    if [ "$filename" == "." ]; then
        break
    fi
done

# Request commit message
read -p "Enter commit message: " commit_message

# Commit with the provided message
if git commit -m "$commit_message"; then
    echo -e "${GREEN}Commit successful.${NC}"
else
    echo -e "${RED}Commit failed.${NC}"
    exit 1
fi

# Ask if user wants to push the commit
read -p "Do you want to push the commit to the remote? (Y/n): " push_response

if [ "$push_response" == "y" ] || [ "$push_response" == "Y" ] || [ -z "$push_response" ]; then
    if git push; then
        echo -e "${GREEN}Push successful.${NC}"
    else
        echo -e "${RED}Push failed.${NC}"
    fi
else
    echo -e "${YELLOW}Commit not pushed to remote.${NC}"
fi
