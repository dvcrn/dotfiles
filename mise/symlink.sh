#!/usr/bin/env bash
# Symlink Mise configuration from dotfiles to ~/.config/mise

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_MISE="${SCRIPT_DIR}"
MISE_DIR="${HOME}/.config/mise"

echo "Setting up Mise symlinks..."
echo "Dotfiles location: ${DOTFILES_MISE}"
echo "Mise directory: ${MISE_DIR}"

# Function to backup and symlink a file/directory
symlink_item() {
    local item_name="$1"
    local source="${DOTFILES_MISE}/${item_name}"
    local target="${MISE_DIR}/${item_name}"

    # Check if source exists
    if [ ! -e "${source}" ]; then
        echo "ERROR: Source ${source} does not exist"
        return 1
    fi

    # Check if target already exists
    if [ -e "${target}" ] || [ -L "${target}" ]; then
        # If it's a symlink pointing to the right place, skip
        if [ -L "${target}" ] && [ "$(readlink "${target}")" = "${source}" ]; then
            echo "✓ ${item_name} is already correctly symlinked"
            return 0
        fi

        # If it's a symlink but pointing to wrong location, remove it
        if [ -L "${target}" ]; then
            echo "  Removing incorrect symlink ${target}"
            rm "${target}"
        # If it's a real file/directory, back it up
        else
            local backup="${target}.bak"
            echo "  Backing up ${target} to ${backup}"
            # Remove old backup if it exists
            [ -e "${backup}" ] && rm -rf "${backup}"
            mv "${target}" "${backup}"
        fi
    fi

    # Create the symlink
    echo "  Creating symlink: ${target} → ${source}"
    ln -s "${source}" "${target}"
    echo "✓ ${item_name} symlinked successfully"
}

# Ensure ~/.config/mise directory exists
mkdir -p "${MISE_DIR}"

# Symlink config.toml
symlink_item "config.toml"

echo ""
echo "Mise configuration symlinked successfully!"
echo "The following items are now managed by dotfiles:"
echo "  - ~/.config/mise/config.toml"
