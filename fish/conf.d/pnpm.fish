# pnpm
set -gx PNPM_HOME "$HOME/.config/pmpm/"
# Drop the unexpanded entry an older version of this file added.
set -gx PATH (string match -v -- '~/.config/pmpm/' $PATH)
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
