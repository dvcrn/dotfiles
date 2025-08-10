# Auto-generate claude command wrappers for ~/.claude/commands templates.
# For each ~/.claude/commands/<name>.md, define `claude--<name>` that runs:
#   claude /<name> [args...]

set -l __cl_commands_dir ~/.claude/commands
if test -d "$__cl_commands_dir"
    for file in $__cl_commands_dir/*.md
        if not test -f $file
            continue
        end

        set -l name (basename $file .md)
        set -l fname "claude--$name"

        if functions -q $fname
            functions -e $fname
        end

        printf 'function %s\n    if not type -q claude\n        echo claude not found >&2; return 127\n    end\n    claude /%s $argv\nend\n' $fname $name | source
    end
end

set -e __cl_commands_dir
