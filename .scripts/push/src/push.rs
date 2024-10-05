#!/usr/bin/env rust-script

use std::io::{self, Write};
use std::process::{Command, exit};

pub fn push() {
    let yellow = "\x1b[1;33m";
    let green = "\x1b[0;32m";
    let red = "\x1b[0;31m";
    let nc = "\x1b[0m"; // No Color


    loop {
        println!("{}This does git add, git commit -m \"\", and git push. For anything more complex, use git directly.{}", yellow, nc);
        if !run_command("git", &["status"]) {
            println!("{}Failed to get git status.{}", red, nc);
            exit(1);
        }

        print!("Enter path to add (or nothing to finish): ");
        io::stdout().flush().unwrap();
        let mut filename = String::new();
        io::stdin().read_line(&mut filename).unwrap();
        let filename = filename.trim();

        if filename.is_empty() {
            break;
        }

        if !run_command("git", &["add", filename]) {
            println!("{}Failed to add file: {}{}", red, filename, nc);
            exit(1);
        }

        if filename == "." {
            break;
        }
    }

    print!("Enter commit message: ");
    io::stdout().flush().unwrap();
    let mut commit_message = String::new();
    io::stdin().read_line(&mut commit_message).unwrap();
    let commit_message = commit_message.trim();

    if !run_command("git", &["commit", "-m", commit_message]) {
        println!("{}Commit failed.{}", red, nc);
        exit(1);
    } else {
        println!("{}Commit successful.{}", green, nc);
    }

    print!("Do you want to push the commit to the remote? (Y/n): ");
    io::stdout().flush().unwrap();
    let mut push_response = String::new();
    io::stdin().read_line(&mut push_response).unwrap();
    let push_response = push_response.trim();

    if push_response.is_empty() || push_response.eq_ignore_ascii_case("y") {
        if !run_command("git", &["push"]) {
            println!("{}Push failed.{}", red, nc);
        } else {
            println!("{}Push successful.{}", green, nc);
        }
    } else {
        println!("{}Commit not pushed to remote.{}", yellow, nc);
    }
}

fn run_command(command: &str, args: &[&str]) -> bool {
    let status = Command::new(command)
        .args(args)
        .status()
        .expect("Failed to execute command");
    status.success()
}


//expose as module


/*
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


*/