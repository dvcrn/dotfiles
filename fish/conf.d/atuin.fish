function _atuin_search_with_height
    _atuin_search --inline-height 20
end

if type -q atuin
    set -gx ATUIN_NOBIND "true"

    atuin init fish | source

    bind \cr _atuin_search_with_height
    bind -M insert \cr _atuin_search_with_height
end