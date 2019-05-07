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

# Ensure the tap is available
brew tap caskroom/versions

# Install java before installing maven
# brew cask install java6 
brew cask install java8
brew cask install java 

# Install my packages that I need installed
brew install gpg2
brew install maven
brew install maven-completion
brew install nvm 
brew install postgresql
brew install zsh-syntax-highlighting

# Install from casks
brew cask install docker
brew cask install gimp
#brew cask install firefox-beta
brew cask install google-chrome-beta
brew cask install google-backup-and-sync
brew cask install gpg-suite
brew cask install itsycal
brew cask install iterm2
#brew cask install onedrive
brew cask install pgadmin4
brew cask install rambox
brew cask install skype
#brew cask install skype-for-business
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
# brew cask install garmin-express

# jenv requires java to be installed first
brew install jenv
brew install rbenv
brew install pyenv
brew install goenv

# Source for jenv from ~/.extra
source ~/.extra

# Install Renv
# https://github.com/viking/Renv
# Install texinfo and basictex first
brew install texinfo
brew cask install basictex
open /usr/local/Caskroom/basictex/*/mactex-basictex-*.pkg
# Install Renv
git clone git@github.com:viking/Renv.git ${HOME}/.Renv
mkdir ${HOME}/.Renv/versions ${HOME}/.Renv/plugins
git clone git@github.com:viking/R-build.git ${HOME}/.Renv/plugins/R-build
eval "$(${HOME}/.Renv/bin/Renv init -)"
R_VER="$(${HOME}/.Renv/bin/Renv install --list | grep -v [a-z] | sort -n | tail -n1 | awk '{print $1}' )"
CONFIGURE_OPTS="--without-x --enable-R-framework --includedir=$(brew --prefix xz)/include --enable-memory-profiling" Renv install --keep --verbose ${R_VER}
pushd ${HOME}/.Renv/sources/${R_VER}/R-${R_VER}
  ./configure --prefix=${HOME}/.Renv/versions/${R_VER} --without-x --enable-R-framework --includedir=$(brew --prefix xz)/include --enable-memory-profiling
  make
  make install
popd
Renv global ${R_VER}

# Invoke bin/reset-env.sh
source ~/bin/reset-env.sh

# Install iterm shell integration
curl -L https://iterm2.com/misc/install_shell_integration_and_utilities.sh | bash

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ${HOME}/.zshrc.pre* ${HOME}/.zshrc

# Remove outdated versions from the cellar.
brew cleanup
