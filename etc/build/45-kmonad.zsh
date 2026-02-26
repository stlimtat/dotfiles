#!/usr/bin/env zsh

mkdir -p ${HOME}/go/src/github.com/kmonad
pushd ${HOME}/go/src/github.com/kmonad
git clone --recursive https://github.com/kmonad/kmonad.git
pushd ${HOME}/go/src/github.com/kmonad/kmonad
open c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/dist/Karabiner-DriverKit-VirtualHIDDevice-5.0.0.pkg
brew install haskell-stack
stack install --flag kmonad:dext
popd
popd

/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
sudo cp ../init/org.pqrs.service.daemon.Karabiner-VirtualHIDDevice-Daemon.plist /Library/LaunchDaemons/org.pqrs.service.daemon.Karabiner-VirtualHIDDevice-Daemon.plist
sudo cp ../init/local.kmonad.plist /Library/LaunchDaemons/local.kmonad.plist

sudo launchctl enable system/org.pqrs.service.daemon.Karabiner-VirtualHIDDevice-Daemon
sudo launchctl enable system/local.kmonad

sudo launchctl bootstrap system /Library/LaunchDaemons/org.pqrs.service.daemon.Karabiner-VirtualHIDDevice-Daemon.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/local.kmonad.plist
