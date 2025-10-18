#!/usr/bin/env bash
# Symlink Claude configuration from dotfiles to ~/.claude

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_CLAUDE="${SCRIPT_DIR}"
CLAUDE_DIR="${HOME}/.claude"

echo "Setting up Claude symlinks..."
echo "Dotfiles location: ${DOTFILES_CLAUDE}"
echo "Claude directory: ${CLAUDE_DIR}"

# Function to backup and symlink a file/directory
symlink_item() {
    local item_name="$1"
    local source="${DOTFILES_CLAUDE}/${item_name}"
    local target="${CLAUDE_DIR}/${item_name}"

    # Check if source exists
    if [ ! -e "${source}" ]; then
        echo "ERROR: Source ${source} does not exist"
        return 1
    fi

    # If target is already a symlink pointing to the right place, skip
    if [ -L "${target}" ] && [ "$(readlink "${target}")" = "${source}" ]; then
        echo "✓ ${item_name} is already correctly symlinked"
        return 0
    fi

    # If target exists and is not a symlink, back it up
    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        local backup="${target}.bak.$(date +%Y%m%d_%H%M%S)"
        echo "  Backing up ${target} to ${backup}"
        mv "${target}" "${backup}"
    elif [ -L "${target}" ]; then
        # Remove old symlink
        echo "  Removing old symlink ${target}"
        rm "${target}"
    fi

    # Create the symlink
    echo "  Creating symlink: ${target} → ${source}"
    ln -s "${source}" "${target}"
    echo "✓ ${item_name} symlinked successfully"
}

# Ensure ~/.claude directory exists
mkdir -p "${CLAUDE_DIR}"

# Symlink selected items
# Point CLAUDE.md to central ai/AGENTS.md
DOTFILES_ROOT="$(cd "${DOTFILES_CLAUDE}/.." && pwd)"
AGENTS_SRC="${DOTFILES_ROOT}/AGENTS.md"
if [ ! -e "${AGENTS_SRC}" ]; then
  echo "ERROR: Central AGENTS.md not found at ${AGENTS_SRC}" >&2
  exit 1
fi
# Temporarily symlink using direct call since symlink_item assumes relative under DOTFILES_CLAUDE
TARGET="${CLAUDE_DIR}/CLAUDE.md"
if [ -L "${TARGET}" ] && [ "$(readlink "${TARGET}")" = "${AGENTS_SRC}" ]; then
  echo "✓ CLAUDE.md is already correctly symlinked to central AGENTS.md"
else
  if [ -e "${TARGET}" ] && [ ! -L "${TARGET}" ]; then
    backup="${TARGET}.bak.$(date +%Y%m%d_%H%M%S)"
    echo "  Backing up ${TARGET} to ${backup}"
    mv "${TARGET}" "${backup}"
  elif [ -L "${TARGET}" ]; then
    echo "  Removing old symlink ${TARGET}"
    rm "${TARGET}"
  fi
  echo "  Creating symlink: ${TARGET} → ${AGENTS_SRC}"
  ln -s "${AGENTS_SRC}" "${TARGET}"
  echo "✓ CLAUDE.md symlinked to central AGENTS.md"
fi

symlink_item "settings.json"
symlink_item "agents"
symlink_item "commands"
symlink_item "plugins"

echo ""
echo "Claude configuration symlinked successfully!"
echo "The following items are now managed by dotfiles:"
echo "  - ~/.claude/CLAUDE.md (→ ai/AGENTS.md)"
echo "  - ~/.claude/settings.json"
echo "  - ~/.claude/agents"
echo "  - ~/.claude/commands"
echo "  - ~/.claude/plugins"
