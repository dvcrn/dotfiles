# pnpm
set -gx PNPM_HOME "~/.config/pmpm/"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
