# VSCode shell integration fix
if test "$TERM_PROGRAM" = "vscode"
    echo "🔧 VSCode detected - configuring shell integration"

    # Manual shell integration
    if test -f (code --locate-shell-integration-path fish 2>/dev/null)
        echo "✅ Loading VSCode shell integration"
        source (code --locate-shell-integration-path fish)
    else
        echo "⚠️  VSCode shell integration not found"
    end

    # Unset problematic environment variable
    if set -q VSCODE_INJECTION
        echo "🧹 Unsetting VSCODE_INJECTION environment variable"
        set -e VSCODE_INJECTION
    end

    # Skip starship in VSCode to avoid conflicts
    echo "⏭️  Skipping starship initialization in VSCode (prevents race conditions)"
else
    # Normal starship initialization for non-VSCode terminals
    if type -q starship
        starship init fish | source
    else
        echo "⚠️  Starship not found"
    end
end
