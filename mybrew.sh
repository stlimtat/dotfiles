#!/usr/bin/env bash

# Install command-line tools using Homebrew.
if [ ! -d /usr/local/Homebrew ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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

# Install garmin
# brew tap caskroom/drivers
# brew install --cask garmin-express

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

# Install Renv
# https://github.com/viking/Renv
# Install texinfo and basictex first
# brew install texinfo
# brew install --cask basictex
# open /usr/local/Caskroom/basictex/*/mactex-basictex-*.pkg
# Install Renv
# git clone https://github.com/viking/Renv.git ${HOME}/.Renv
# mkdir ${HOME}/.Renv/versions ${HOME}/.Renv/plugins
# git clone https://github.com/viking/R-build.git ${HOME}/.Renv/plugins/R-build
# eval "$(${HOME}/.Renv/bin/Renv init -)"
# R_VER="$(${HOME}/.Renv/bin/Renv install --list | grep -v [a-z] | sort -n | tail -n1 | awk '{print $1}' )"
# CONFIGURE_OPTS="--without-x --enable-R-framework --includedir=$(brew --prefix xz)/include --enable-memory-profiling" Renv install --keep --verbose ${R_VER}
# pushd ${HOME}/.Renv/sources/${R_VER}/R-${R_VER}
#   ./configure --prefix=${HOME}/.Renv/versions/${R_VER} --without-x --enable-R-framework --includedir=$(brew --prefix xz)/include --enable-memory-profiling
#   make
#   make install
# popd
# Renv global ${R_VER}

# Invoke bin/reset-env.sh
# source ~/bin/reset-env.sh

# Install iterm shell integration
curl -L https://iterm2.com/misc/install_shell_integration_and_utilities.zsh | zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Remove outdated versions from the cellar.
brew cleanup

# Link the vim
ln -sf ${HOME}/.config/nvim ${HOME}/.vim
ln -sf ${HOME}/.config/nvim/init.vim ${HOME}/.vimrc
mv ${HOME}/.zshrc.pre* ${HOME}/.zshrc
