#!/usr/bin/env zsh
#
SCRIPT_DIR=$(dirname ${0})
if [[ "${SCRIPT_DIR}" = "." ]]; then
  SCRIPT_DIR=$(pwd)
fi
#
# Check if installing for dev environment
DEV_SETUP=$1
# 
# Goes up one directory
DOTFILES_DIR=$(dirname $SCRIPT_DIR)
#
# Install command-line tools using Homebrew.
HOMEBREW_DIR="/usr/local/Homebrew"
if [[ "$(uname -m)" != "x86_64" ]]; then
  HOMEBREW_DIR="/opt/homebrew"
fi
pushd ${DOTFILES_DIR}
  # git to latest
  git pull origin master
  # rsync all dotfiles to ${HOME} only if .devenv does not exists
  if [[ ! -f "${HOME}/.devenv" ]]; then
    rsync --exclude ".git/" \
      --exclude ".DS_Store" \
      --exclude ".osx" \
      --exclude ".macos" \
      --exclude ".tokens" \
      --exclude "*.sh" \
      --exclude "*.plist" \
      --exclude "init/" \
      --exclude "not-bin/" \
      --exclude "README.md" \
      --exclude "LICENSE-MIT.txt" \
      -avh --no-perms \
      ${DOTFILES_DIR}/ \
      ${HOME}/
  fi
  source ~/.zshrc
  # Install Homebrew
  if [[ ! -d "${HOMEBREW_DIR}" ]]; then
    echo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
  #
  # Make sure we’re using the latest Homebrew.
  brew tap homebrew/bundle
  #
  # Using brew bundle to install from Brewfile
  # https://github.com/Homebrew/homebrew-bundle
  brew bundle --file ${DOTFILES_DIR}/not-bin/Brewfile
  #
  # Install dev only bundles
  if [[ "${DEV_SETUP}" != "" ]]; then
    brew bundle --file ${DOTFILES_DIR}/not-bin/Brewfile-DEV
  fi
  #
  # Remove outdated versions from the cellar.
  brew cleanup
  #
  # Source for jenv from ~/.extra
  source ${}/.zshrc
  #
  # Install iterm shell integration
  # https://iterm2.com/documentation-shell-integration.html
  if [[ ! -d ${HOME}/.iterm2_shell_integration.zsh ]]; then
    curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
    source ~/.iterm2_shell_integration.zsh
  fi
  #
  # iterm color schemes
  # https://github.com/mbadolato/iTerm2-Color-Schemes
  if [[ ! -d ${HOME}/go/src/github.com/mbadolato/iTerm2-Color-Schemes ]]; then
    mkdir -p ${HOME}/go/src/github.com/mbadolato
    git clone https://github.com/mbadolato/iTerm2-Color-Schemes ${HOME}/go/src/github.com/mbadolato/iTerm2-Color-Schemes
    pushd ${HOME}/go/src/github.com/mbadolato/iTerm2-Color-Schemes
    /bin/bash tools/import-scheme.sh "Solarized Darcula" "Solarized Dark - Patched" "Solarized Dark Higher Contrast"
    popd
  fi
  #
  # oh-my-zsh
  # https://github.com/ohmyzsh/ohmyzsh
  if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    rsync -ar ${DOTFILES_DIR}/init/abnormal.zsh-theme ${HOME}/.oh-my-zsh/custom/themes
  fi
  if [[ "${DEV_SETUP}" != "" ]]; then
    #
    # Install colima
    # https://github.com/abiosoft/colima
    if [[ ! -d ${HOME}/.colima ]]; then
      colima start --cpu 4 --memory 8
    fi
    #
    # Install gvm
    # https://github.com/moovweb/gvm
    if [[ ! -d ${HOME}/.gvm ]]; then
      curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | /bin/zsh -
    fi
    #
    # Lunarvim
    # Using https://www.lunarvim.org/
    if [[ ! -f ${HOME}/.local/bin/lvim ]]; then
      luarocks install luacheck
      /bin/zsh ${DOTFILES_DIR}/bin/reinstall-lvim.sh
    fi
    #
    # python
    # https://github.com/pyenv/pyenv
    if [[ ! -d ${HOME}/.pyenv/versions ]]; then
      # PY_VER=$(pyenv install --list | grep "  3.10" | tail -n 1 | sed -e 's/ //g')
      # pyenv install ${PY_VER}
      # pyenv global ${PY_VER}
      pyenv install 3.8.8
      pyenv global 3.8.8
      eval "$(pyenv init --path)"
      pip install --upgrade pip
      /bin/zsh ${DOTFILES_DIR}/bin/restore-venv.sh
    fi
  fi
  [[ -f ${HOME}/.zshrc.pre* ]] && rm ${HOME}/.zshrc.pre* && cp ${DOTFILES_DIR}/.zshrc ${HOME}/.zshrc
  [[ -f ${HOME}/*brew.sh ]] && rm -rf ${HOME}/*brew.sh
popd 
