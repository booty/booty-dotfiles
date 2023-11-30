#!/bin/zsh

defaults -currentHost write -globalDomain AppleFontSmoothing -int 1

defaults write com.apple.finder AppleShowAllFiles -bool true

defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

killall Finder
