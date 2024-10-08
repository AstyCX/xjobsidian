#!/usr/bin/bash

if [ -f ~/.xjobsidian_config ]; then
    source ~/.xjobsidian_config
else
    echo "Error: Configuration file ~/.xjobsidian_config not found. Please run the installation script first."
    exit 1
fi

# Use the `vault_path` and `template_path` variables from the config file
obsidian="$vault_path"
template="$template_path"
notes="$notes_path"

# Set the vault name
vault_name=$(basename "$obsidian")

get_unique_filename() {
    local original_base_name=$1
    local directory=$2
    local base_name=$original_base_name
    local counter=1

    # If the file already exists, ask if the user wants to open the old file or create a new one
    while [ -e "${directory}/${base_name}.xopp" ]; do
        read -p "Do you want to open the existing file? (y/n): " choice
        case "$choice" in
            y|Y )
                echo "${base_name}"
                return 1  # Indicating that we want to open the existing file
                ;;
            n|N )
                base_name="${original_base_name}_${counter}"
                counter=$((counter + 1))
                ;;
            * )
                echo "Invalid option. Please enter 'y' or 'n'." >&2
                ;;
        esac
    done

    # Return the new unique filename (without the path)
    echo "${base_name}"
    return 0  # Indicating that we want to create a new file
}

# Read inputs
lesson="${1^}"
if [ -z "$lesson" ]; then
    read -p "Enter lesson: " input
    lesson="${input^}"
fi

echo "$lesson"

topic="${2^}"
if [ -z "$topic" ]; then
    read -p "Enter topic: " input_2
    topic="${input_2^}"
fi

echo "$topic"

# Check if the lesson directory exists
if [ ! -d "$obsidian/$notes/$lesson" ]; then
    echo "Error: $lesson hasn't yet been added in $obsidian/$notes."
    exit 1  # Exit the script with a non-zero status to indicate an error
fi

# Generate the unique topic filename or open the existing one based on user input
unique_topic=$(get_unique_filename "$topic" "$obsidian/$notes/$lesson")

if [ $? -eq 0 ]; then
    # Create the .xopp and .md files with the unique name
    cp "$template" "$obsidian/$notes/$lesson/$unique_topic.xopp"
    touch "$obsidian/$notes/$lesson/$unique_topic.md"

    # Add link to the PDF in the markdown file
    echo "![[$unique_topic.pdf]]" >> "$obsidian/$notes/$lesson/$unique_topic.md"
fi

echo "$unique_topic - debug echo"

# Open the .xopp file in xournalpp
xournalpp "$obsidian/$notes/$lesson/$unique_topic.xopp" &

# URL encode the lesson and topic names (in case they have spaces or special characters)
encoded_lesson=$(echo "$lesson" | sed 's/ /%20/g')
encoded_topic=$(echo "$unique_topic" | sed 's/ /%20/g')

# Use the Obsidian URI to open the markdown file
xdg-open "obsidian://open?vault=$vault_name&file=School%20Notes/$encoded_lesson/$encoded_topic.md"

# Monitor the .xopp file for modifications and update the PDF
while true; do
    inotifywait -e modify "$obsidian/$notes/$lesson/$unique_topic.xopp"
    xournalpp --create-pdf="$obsidian/$notes/$lesson/$unique_topic.pdf" "$obsidian/$notes/$lesson/$unique_topic.xopp"
    echo "PDF for $unique_topic updated."
done