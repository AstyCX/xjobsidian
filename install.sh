#!/usr/bin/env bash

# Detect operating system for package installation
OS="$(uname -s)"

# Detect if running under Windows Subsystem for Linux
if grep -qi microsoft /proc/version 2>/dev/null; then
    OS="WSL"
fi

install_cmd() {
    case "$OS" in
        Linux*|WSL*)
            sudo apt update && sudo apt install -y "$1"
            ;;
        Darwin*)
            if ! command -v brew &>/dev/null; then
                echo "Homebrew is required to install $1. Please install Homebrew first: https://brew.sh" >&2
                return 1
            fi
            brew install "$1"
            ;;
        *)
            echo "Please install $1 manually for your platform." >&2
            return 1
            ;;
    esac
}

# Check if required commands are available
for cmd in xournalpp inotifywait; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        read -p "Error: $cmd is not installed. Install it automatically? (y/n): " choice
        case "$choice" in
            y|Y )
                install_cmd "$cmd" || {
                    echo "$cmd is required. Exiting." >&2
                    exit 1
                }
                ;;
            n|N )
                echo "$cmd is required. Exiting." >&2
                exit 1
                ;;
            * )
                echo "Invalid option. Please enter 'y' or 'n'." >&2
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
# ~/.xjobsidian_config

# Path to the Obsidian Vault
vault_path="$vault_path"

# Path to the template file for new .xopp files
template_path="$template_path"

# Path to the notes folder 
notes_path="$notes_path"

EOL

# Move the script to /usr/local/bin to make it globally executable
sudo cp ./usr/local/bin/xjobsidian.sh /usr/local/bin/xjobsidian
sudo chmod +x /usr/local/bin/xjobsidian

echo "Configuration saved to ~/.xjobsidian_config"
echo "Installation complete."
