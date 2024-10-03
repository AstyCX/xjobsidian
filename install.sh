#!/usr/bin/bash

# Check if required commands are available
for cmd in xournalpp inotifywait; do
    if ! command -v "$cmd" &> /dev/null; then
        read -p "Error: $cmd is not installed. Install it automatically? (y/n): " choice
        case "$choice" in
            y|Y )
                sudo apt update
                sudo apt install "$cmd"
                sudo apt upgrade
                ;;
            n|N )
                echo "$cmd is required. Exiting."
                exit 1
                ;;
            * )
                echo "Invalid option. Please enter 'y' or 'n'."
                exit 1
                ;;
        esac
    fi
done


# Obsidian Vault path
read -p "Enter the path to your Obsidian Vault (FROM ROOT): " vault_input
echo $vault_input
if [ -z "$vault_input" ]; then
    echo "Error: Vault path cannot be empty."
    exit 1
fi
vault_path="$vault_input"

# Template file path
read -p "Enter the path to your template .xopp file (FROM ROOT): " template_input
echo $template_input
if [ -z "$template_input" ]; then
    echo "Error: Template path cannot be empty."
    exit 1
fi
template_path="$template_input"

# Notes folder path
read -p "Enter the path to your notes folder (FROM INSIDE OF THE VAULT): " notes_input
echo $notes_input
if [ -z "$notes_input" ]; then
     echo "Error: Notes path cannot be empty."
     exit 1
fi
notes_path="$notes_input"

cat <<EOL > ~/.xjobsidian_config
# ~/.xjobsidian_configcat <<EOL > ~/.xjobsidian_config
# ~/.xjobsidian_config

# Path to the Obsidian Vault
vault_path="$vault_path"

# Path to the template file for new .xopp files
template_path="$template_path"

# Path to the notes folder 
notes_path="$notes_path"

EOL

# Move the script to /usr/local/bin to make it globally executable
sudo cp https://github.com/AstyCX/xjobsidian/blob/main/usr/local/bin/xjobsidian.sh /usr/local/bin/xjobsidian
sudo chmod +x /usr/local/bin/xjobsidian

echo "Configuration saved to ~/.xjobsidian_config"
echo "Installation complete."
