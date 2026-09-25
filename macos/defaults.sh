#!/bin/bash
# macOS system preferences from Setup Day.

echo "-----> Setting keyboard repeat to fastest"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

echo "-----> Setting bottom-right hot corner to Show Desktop"
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

echo "-----> Restarting Dock to apply hot corner change"
killall Dock
