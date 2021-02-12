#!/usr/bin/env bash

# Install command-line tools using Homebrew.
if [ ! -d /usr/local/Homebrew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Run the original brew.sh
source ./brew.sh

# Upgrade any already-installed formulae.
brew upgrade

# Install java before installing maven
brew tap adoptopenjdk/openjdk
# brew install --cask java6
# brew install --cask java8
brew install --cask java

# Install my packages that I need installed
brew install awscli
brew install aws-sam-cli
brew install kafka
brew install kafkacat
# brew install maven
# brew install maven-completion
brew install mongodb-database-tools
brew install nvm
# brew install postgresql
brew install tmux
# brew install zsh-syntax-highlighting

# Install from casks
brew install --cask brave-browser
brew install --cask docker
brew install --cask gimp
brew install --cask firefox
# brew install --cask firefox-beta
brew install --cask goland
# brew install --cask google-chrome
# brew install --cask google-backup-and-sync
# brew install --cask gpg-suite
# brew install --cask itsycal
brew install --cask iterm2
brew install --cask keka
brew install --cask kekadefaultapp
# brew install --cask onedrive
brew install --cask openvpn-connect
# brew install --cask pgadmin4
brew install --cask postman
brew install --cask rambox
brew install --cask rectangle
# brew install --cask skype
# brew install --cask skype-for-business
brew install --cask steam
# brew install --cask vimr
# brew install --cask virtualbox
# brew install --cask virtualbox-extension-pack
# brew install --cask visual-studio-code
brew install --cask vlc
brew install --cask zoomus

# Install neovim
brew tap neovim/neovim
brew install neovim

# Install fonts
brew tap homebrew/cask-fonts
brew install --cask font-arial
brew install --cask font-cascadia-code
brew install --cask font-jetbrains-mono

# Install microsoft fonts
brew tap colindean/fonts-nonfree
brew install --cask font-microsoft-office

# jenv requires java to be installed first
brew install jenv
# brew install rbenv
brew install pyenv
# brew install --HEAD goenv

# Source for jenv from ~/.extra
source ~/.extra

# Source for aws related
brew tap aws/tap
brew install --cask amazon-chime

# Source for mongo related
brew tap mongodb/brew
brew install --cask mongodb-compass

# Source for zsa-wally
brew tap homebrew/cask-drivers
brew install --cask zsa-wally

# Invoke bin/reset-env.sh
# source ~/bin/reset-env.sh

# Install iterm shell integration
curl -L https://iterm2.com/misc/install_shell_integration_and_utilities.zsh | zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Remove outdated versions from the cellar.
brew cleanup

# Link the vim
# Using https://github.com/amix/vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cd ~/.vim_runtime
python update_plugins.py
cd
mkdir -p ~/.config/nvim
ln -sf ~/.vimrc ~/.config/nvim/init.vim

# ln -sf ${HOME}/.config/nvim ${HOME}/.vim
# ln -sf ${HOME}/.config/nvim/init.vim ${HOME}/.vimrc
mv ${HOME}/.zshrc.pre* ${HOME}/.zshrc


