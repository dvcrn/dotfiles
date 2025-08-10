# Auto-generate codex command wrappers from Claude prompts.
# This file is sourced by Fish on startup; we define functions immediately.

# Use fixed location for Claude commands
set -l __cc_commands_dir ~/.claude/commands
if test -d "$__cc_commands_dir"
    for file in $__cc_commands_dir/*.md
        if not test -f $file
            continue
        end

        set -l name (basename $file .md)
        set -l fname "codex--$name"

        if functions -q $fname
            functions -e $fname
        end

        # Define a wrapper that calls codex with args and the file contents as a single prompt argument.
        # Use `source` to avoid eval-quoting pitfalls.
        set -l __cc_fpath (string escape -- $file)
        printf 'function %s\n    if not type -q codex\n        echo codex not found >&2; return 127\n    end\n    if not test -f %s\n        echo "prompt file missing: %s" >&2; return 1\n    end\n    set -l __prompt (string collect < %s)\n    codex $argv "$__prompt"\nend\n' $fname $__cc_fpath $__cc_fpath $__cc_fpath | source
    end
end
set -e __cc_commands_dir
