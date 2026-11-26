# Starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

# Mise (development tool version manager)
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/david/.lmstudio/bin"
# End of LM Studio CLI section



# Added by Antigravity CLI installer
export PATH="/Users/david/.local/bin:$PATH"
