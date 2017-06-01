#!/usr/bin/env bash

# Install command-line tools using Homebrew.
if [ ! -d /usr/local/Homebrew ]; then
				/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install my packages that I need installed
brew install gpg2
brew install maven
brew install maven-completion
brew install nvm 
brew install postgresql

# Ensure the tap is available
brew tap caskroom/versions

# Install from casks
brew cask install docker
brew cask install franz
brew cask install gimp
brew cask install google-chrome-beta
brew cask install google-drive
brew cask install gpgtools
brew cask install iterm2
brew cask install java6 
brew cask install java7 
brew cask install java 
brew cask install kodi
brew cask install onedrive
brew cask install pgadmin4
brew cask install skype
brew cask install skype-for-business
brew cask install spectacle 
brew cask install vimr
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vlc

# Install neovim
brew tap neovim/neovim
brew install neovim

# Install fonts
brew tap caskroom/fonts
brew cask install font-arial
brew cask install font-awesome-terminal-fonts 
brew cask install font-fontawesome

# Install microsoft fonts
brew tap colindean/fonts-nonfree
brew cask install font-microsoft-office

# Install garmin
brew tap caskroom/drivers
brew cask install garmin-express

# jenv requires java to be installed first
brew install jenv

# Source for jenv from ~/.extra
source ~/.extra
jenv add /Library/Java/JavaVirtualMachines/$( ls /Library/Java/JavaVirtualMachines | grep 1.6 )/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/$( ls /Library/Java/JavaVirtualMachines | grep 1.7 )/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/$( ls /Library/Java/JavaVirtualMachines | grep 1.8 )/Contents/Home

# Install rbenv
brew install rbenv
eval "$(rbenv init -)"
RB_VERSION=$(rbenv install -l | grep -v [a-z] | sort -n | tail -n1)
rbenv install ${RB_VERSION}
rbenv global ${RB_VERSION}
eval "$(rbenv init -)"

# Install rbenv
brew install pyenv
eval "$(pyenv init -)"
PY_VER="$(pyenv install --list | grep -v [a-z] | grep 2.7 | tail -n1)"
pyenv install ${PY_VER}
pyenv global ${PY_VER}
eval "$(pyenv init -)"
curl -o- https://bootstrap.pypa.io/get-pip.py | python -
pip install --upgrade pip setuptools

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install iterm shell integration
curl -L https://iterm2.com/misc/install_shell_integration_and_utilities.sh | bash

# Remove outdated versions from the cellar.
brew cleanup
