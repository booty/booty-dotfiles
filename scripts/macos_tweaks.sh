#!/bin/zsh

defaults -currentHost write -globalDomain AppleFontSmoothing -int 1

defaults write com.apple.finder AppleShowAllFiles -bool true

defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# always default to list view in Finder
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

killall Finder

echo "I'm tweakin"
