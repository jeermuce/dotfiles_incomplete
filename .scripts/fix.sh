#!/bin/bash
#check if oxlint and eslint are installed
if ! command -v oxlint &> /dev/null; then
#if currently at ~, install oxlint globally
    echo "{GREEN}INSTALLING OXLINT@LATEST LOCALLY AS DEV DEPENDENCY{NC}"
    bun install oxlint@latest  -D
    
    
fi

if ! command -v eslint &> /dev/null; then
#if currently at ~, install eslint globally
    echo "{GREEN}INSTALLING ESLINT@LATEST LOCALLY AS DEV DEPENDENCY{NC}"
    bun install eslint@latest  -D
    echo "{GREEN}INSTALLING ESLINT PLUGINS{NC}"
    bun eslint --init

fi

bun oxlint . --fix && bun eslint . --fix