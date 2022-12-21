# Homebrew
set -gx fish_user_paths /opt/homebrew/bin $fish_user_paths
set -gx PATH $PATH /opt/homebrew/bin

# Golang
set -gx GOPATH ~/go
set -gx PATH ~/go/bin $PATH

# etc
set -gx PATH $PATH ~/.cargo/bin
set -gx PATH $PATH (yarn global bin)
set -gx PATH $PATH ~/src/solana/bin
