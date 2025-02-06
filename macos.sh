#!/bin/bash

# disable sleep on power change when in clamshell mode
sudo pmset disablesleep 1

# don't send .DS_Store files to network shares or removable drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
