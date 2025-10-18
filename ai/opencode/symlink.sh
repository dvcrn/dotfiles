#!/usr/bin/env bash
# Symlink OpenCode configuration from dotfiles to ~/.config/opencode

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_OPENCODE="${SCRIPT_DIR}"
OPEN_DIR="${HOME}/.config/opencode"

echo "Setting up OpenCode symlinks..."
echo "Dotfiles location: ${DOTFILES_OPENCODE}"
echo "OpenCode directory: ${OPEN_DIR}"

symlink_item() {
  local item_name="$1"
  local source="${DOTFILES_OPENCODE}/${item_name}"
  local target="${OPEN_DIR}/${item_name}"

  if [ ! -e "${source}" ]; then
    echo "ERROR: Source ${source} does not exist"
    return 1
  fi

  if [ -L "${target}" ] && [ "$(readlink "${target}")" = "${source}" ]; then
    echo "✓ ${item_name} is already correctly symlinked"
    return 0
  fi

  if [ -e "${target}" ] && [ ! -L "${target}" ]; then
    local backup="${target}.bak.$(date +%Y%m%d_%H%M%S)"
    echo "  Backing up ${target} to ${backup}"
    mv "${target}" "${backup}"
  elif [ -L "${target}" ]; then
    echo "  Removing old symlink ${target}"
    rm "${target}"
  fi

  echo "  Creating symlink: ${target} → ${source}"
  ln -s "${source}" "${target}"
  echo "✓ ${item_name} symlinked successfully"
}

mkdir -p "${OPEN_DIR}"

symlink_item "agent"
symlink_item "command"
symlink_item "opencode.json"

# Central AGENTS.md via intermediate repo symlink
AGENTS_SRC="${DOTFILES_OPENCODE}/AGENTS.md"  # this symlink points to ../AGENTS.md
TARGET="${OPEN_DIR}/AGENTS.md"
if [ -L "${TARGET}" ] && [ "$(readlink "${TARGET}")" = "${AGENTS_SRC}" ]; then
  echo "✓ AGENTS.md is already correctly symlinked (via opencode/AGENTS.md)"
else
  if [ -e "${TARGET}" ] && [ ! -L "${TARGET}" ]; then
    backup="${TARGET}.bak.$(date +%Y%m%d_%H%M%S)"; echo "  Backing up ${TARGET} to ${backup}"; mv "${TARGET}" "${backup}";
  elif [ -L "${TARGET}" ]; then
    echo "  Removing old symlink ${TARGET}"; rm "${TARGET}";
  fi
  echo "  Creating symlink: ${TARGET} → ${AGENTS_SRC}"; ln -s "${AGENTS_SRC}" "${TARGET}"; echo "✓ AGENTS.md symlinked successfully (via opencode/AGENTS.md)";
fi

echo ""
echo "OpenCode configuration symlinked successfully!"
echo "The following items are now managed by dotfiles:"
echo "  - ~/.config/opencode/agent"
echo "  - ~/.config/opencode/command"
echo "  - ~/.config/opencode/opencode.json"
echo "  - ~/.config/opencode/AGENTS.md (→ ai/AGENTS.md)"
