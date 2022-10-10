source ~/.config/fish/alias.fish
source ~/.config/fish/functions.fish

# Fish syntax highlighting
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

set -gx fish_user_paths /opt/homebrew/bin $fish_user_paths

set -gx CARGO_NET_GIT_FETCH_WITH_CLI true
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx GOPATH ~/go
set -gx PATH ~/go/bin $PATH
set -gx GO111MODULE auto
set -gx GOPROXY direct
set -gx GOPRIVATE github.com
set -gx EDITOR (which nvim)
set -gx NODE_OPTIONS --max-old-space-size=8192

set -gx PATH $PATH /opt/homebrew/bin
set -gx PATH $PATH ~/.cargo/bin
set -gx PATH $PATH (yarn global bin)
set -gx PATH $PATH ~/src/solana/bin

export CGO_LDFLAGS="-L/opt/homebrew/opt/openssl/lib"
export CGO_CPPFLAGS="-I/opt/homebrew/opt/openssl/include"

alias ibrew "arch -x86_64 /usr/local/bin/brew"


# Install Starship
starship init fish | source

# direnv
if type -q direnv
    eval (direnv hook fish)
end

# pyenv
if type -q pyenv
    pyenv init - | source
end

if type -q fnm
   fnm env | source
end

# gcloud
# set -g -x "CLOUDSDK_PYTHON" "/usr/local/opt/python@3.8/libexec/bin/python"
# set -g fish_user_paths "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc" $fish_user_paths

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'; end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/david/google-cloud-sdk/path.fish.inc' ]; . '/Users/david/google-cloud-sdk/path.fish.inc'; end

