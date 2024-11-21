


# Main function
ns() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <filename>"
        exit 1
    else
        main "$1"
    fi
    # Function to check if the provided string is a valid filename
    is_valid_filename() {
        # A valid filename cannot contain '/', NULL, or any of these characters: (<>:"/\|?*)
        if [[ "$1" =~ [/:] ]]; then
            return 1
        fi
        return 0
    }
    filename="$1"
    
    # Remove .sh extension if present
    filename="${filename%.sh}"
    
    # Validate the filename
    if ! is_valid_filename "$filename"; then
        echo "Invalid filename: $filename"
        exit 1
    fi
    
    # Open or create the file in Neovim
    nvim ~/.scripts/"$filename".sh
    
    # Check if argument is provided
    
}


