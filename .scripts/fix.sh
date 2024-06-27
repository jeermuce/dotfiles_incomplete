#!/bin/bash
#check if oxlint and eslint are installed
if ! command -v oxlint &> /dev/null; then
#if currently at ~, install oxlint globally
    if [ "$HOME" == "/home/osira" ] || [ "$HOME" == "/home/osira" ]; then
        echo "{YELLOW}oxlint is not installed, and currently at home\nDo you want to install it globally?{NC}"
        read -p "(y/n): " install_response
        if [ "$install_response" == "y" ] || [ "$install_response" == "Y" ]; then
            global_oxlint
        else
            echo "oxlint not installed"
            exit 1
        fi
    else
        echo "{YELLOW}oxlint is not installed, and currently not at home{NC}"
        local_oxlint
    fi

fi

function local_oxlint() {
    echo "{GREEN}INSTALLING OXLINT@LATEST LOCALLY AS DEV DEPENDENCY{NC}"
    bun install oxlint@latest -D
}
function global_oxlint() {
    echo "{YELLLOW}INSTALLING OXLINT@LATEST GLOBALLY, this is not recommended{NC}"
    bun install oxlint@latest --global
}


bun oxlint . --fix && bun eslint . --fix