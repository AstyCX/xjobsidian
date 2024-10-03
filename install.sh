#!/usr/bin/bash

# Obsidian Vault path
read -p "Enter the path to your Obsidian Vault: " vault_input
if [ -z "$vault_input" ]; then
    echo "Error: Vault path cannot be empty."
    exit 1
fi
vault_path="$vault_input"

# Template file path
read -p "Enter the path to your template .xopp file: " template_input
if [ -z "$template_input" ]; then
    echo "Error: Template path cannot be empty."
    exit 1
fi
template_path="$template_input"

cat <<EOL > ~/.xjobsidian_config
# ~/.xjobsidian_configcat <<EOL > ~/.mytool_config
# ~/.mytool_config

# Path to the Obsidian Vault
vault_path="$vault_path"

# Path to the template file for new .xopp files
template_path="$template_path"
EOL

echo "Configuration saved to ~/.mytool_config"
echo "Installation complete."
