# Save screenshots into ~/Screenshots/ instead of desktop
defaults write com.apple.screencapture location ~/Screenshots/

# Never re-open previous windows
defaults write -g ApplePersistence -bool no

# defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock autohide-time-modifier -float 0.15

# disable key hold for accented input
defaults write -g ApplePressAndHoldEnabled -bool false

# goodbye gatekeeper
sudo spctl --master-disable

killall Dock
