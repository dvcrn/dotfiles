if type -q fnm
    fnm completions --shell fish | source
    fnm env --use-on-cd | source
end
