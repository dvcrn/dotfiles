# Homebrew
set -gx fish_user_paths /opt/homebrew/bin $fish_user_paths
fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin

# Golang
set -gx GOPATH ~/go
fish_add_path ~/go/bin

# etc
fish_add_path ~/.cargo/bin
if type -q yarn
    fish_add_path (yarn global bin)
end

fish_add_path "/Users/david/Library/Application Support/JetBrains/Toolbox/scripts"
fish_add_path /opt/homebrew/opt/libpq/bin

if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc' ]
    . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'
end

fish_add_path /usr/local/bin/jetbrains
fish_add_path /opt/homebrew/opt/ruby/bin

# Keep Bun's local binaries ahead of other Bun installations.
fish_add_path --move "/Users/david/.bun/bin"
