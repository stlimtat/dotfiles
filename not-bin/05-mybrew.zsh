#!/usr/bin/env zsh
# Install Homebrew
if [[ ! -d "${HOMEBREW_DIR}" ]]; then
  echo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
# Set PATH, MANPATH, etc., for Homebrew.
[[ -f "${HOMEBREW_DIR}/bin/brew" ]] && eval "$(${HOMEBREW_DIR}/bin/brew shellenv)"
#
# Make sure we’re using the latest Homebrew.
brew tap homebrew/bundle

pushd ${DOTFILES_DIR}
  #
  # Using brew bundle to install from Brewfile
  # https://github.com/Homebrew/homebrew-bundle
  brew bundle --file ${DOTFILES_DIR}/not-bin/Brewfile
  #
  # Install dev only bundles
  if [[ "${DEV_SETUP}" != "" ]]; then
    brew bundle --file ${DOTFILES_DIR}/not-bin/Brewfile-DEV
  fi
popd
#
# Remove outdated versions from the cellar.
brew cleanup
#
# Source for jenv from ~/.extra
source ${HOME}/.zshrc
