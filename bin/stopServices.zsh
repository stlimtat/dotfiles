#!/bin/sh
#You need to use the launchctl command as follows:
#Disable Cups 2.0
#if [ "$(grep "Sandboxing Off" /etc/cups/cups-files.conf)" = "" ]; then
#    sudo sh -c 'echo "Sandboxing Off" | sudo tee -a /etc/cups/cups-files.conf > /dev/null'
#fi

#Disable notification center, with these 2 commands:
sudo defaults write com.apple.notificationcenterui KeepAlive -bool false
sudo killall NotificationCenter

# https://www.mutface.com/wp-content/cache/all/speed-up-mojave-mac-os-technical-guide/index.html
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write -g QLPanelAnimationDuration -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock launchanim -bool false
sudo sysctl debug.lowpri_throttle_enabled=0

# disable Game Center daemon
defaults write com.apple.gamed Disabled -bool true
