#!/usr/bin/env zsh
#
SCRIPT_DIR=$(dirname ${0})
if [[ "${SCRIPT_DIR}" = "." ]]; then
  SCRIPT_DIR=$(pwd)
fi
#
# Check if installing for dev environment
echo -n "Are you setting up a dev machine (Y|n)?"
read DEV_SETUP
[[ "${DEV_SETUP}" =~ "[nN]" ]] && unset DEV_SETUP
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
      --exclude "etc/" \
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
  # Set PATH, MANPATH, etc., for Homebrew.
  [[ -f "${HOMEBREW_DIR}/bin/brew" ]] && eval "$(${HOMEBREW_DIR}/bin/brew shellenv)"
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
  source ${HOME}/.zshrc
  #
  # oh-my-zsh
  # https://github.com/ohmyzsh/ohmyzsh
  if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # rsync -ar ${DOTFILES_DIR}/init/abnormal.zsh-theme ${HOME}/.oh-my-zsh/custom/themes
    # Install the powerlevel10k theme
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  fi
  if [[ "${DEV_SETUP}" != "" ]]; then
    #
    # Run init again
    [[ -f "${HOME}/.zshrc.pre*" ]] && rm ${HOME}/.zshrc.pre* && cp ${DOTFILES_DIR}/.zshrc ${HOME}/.zshrc
    source ${HOME}/.zshrc
    #
    # Install colima
    # https://github.com/abiosoft/colima
    if [[ ! -d ${HOME}/.colima ]]; then
      colima start --cpu 5 --memory 16
    fi
    #
    # Install fzf
    [[ -f "$(brew --prefix)/opt/fzf/install" ]] && $(brew --prefix)/opt/fzf/install
    if [[ -f "${HOMEBREW_DIR}/bin/asdf" ]]; then
      #
      # asdf
      # https://github.com/asdf-vm/asdf
      asdf plugin add golang
      asdf plugin add nodejs 
      asdf plugin add python 
      asdf plugin add terraform
      asdf plugin add terragrunt
      #
      # nodejs
      # https://github.com/pyenv/pyenv
      asdf install nodejs latest
      asdf global nodejs latest
      mkdir ${HOME}/.npm-global
      npm config set prefix "${HOME}/.npm-global"
      export PATH=${HOME}/.npm-global/bin:$PATH
      #
      # python
      # https://github.com/pyenv/pyenv
      asdf install python 3.8.10
      asdf install python latest
      asdf global python latest
    fi
    #
    # Lunarvim
    # Using https://www.lunarvim.org/
    if [[ ! -f ${HOME}/.local/bin/lvim ]]; then
      luarocks install luacheck
      [[ "$(which node)" == "" ]] && echo "No node detected"
      [[ "$(which python)" == "" ]] && echo "No python detected"
      [[ "$(which rust)" == "" ]] && echo "No rust detected"
      /bin/zsh ${DOTFILES_DIR}/bin/reinstall-lvim.sh 1
    fi
    #
    # Abnormal
    # Adding abnormal-security brew tap
    # Before doing this, you need to add ssh key to github account
    if [[ ! -f "${HOME}/.ssh/id_ed25519.pub" ]]; then
      ssh-keygen -t ed25519 -f ${HOME}/id_ed25519 -C 'st_lim@tanjiro' -a 100 -o
      ssh-add -K
      echo "Please login with a valid id on github"
      [[ -f "/Applications/Brave Browser.app" ]] && open -a /Applications/Brave Browser.app https://github.com/
      if [[ "$(brew tap | grep abnormal-security)" == "" ]]; then
        brew tap \
          abnormal-security/abnormal \
          git@github.com:abnormal-security/homebrew-abnormal.git
        brew install \
          abnormal-security/abnormal/{mupdf,rocksdb} \
          cmake \
          freetype \
          libpng \
          hdf5 \
          pkg-config \
          snappy \
          swig \
          virtualenv
        mkdir ~/.matplotlib
        cat > ~/.matplotlib/matplotlibrc <<EOF
backend: TkAgg
EOF
        if [[ "$(uname -m)" != "x86_64" ]]; then
          #
          # hdf5
          cat > /opt/homebrew/lib/pkgconfig/hdf5.pc <<EOF
prefix=/opt/homebrew/opt/hdf5
libdir=${prefix}/lib
includedir=${prefix}/include

Name: hdf5
Description: File format designed to store large amounts of data
Version: 1.12.1
Libs: -L${libdir}
Cflags: -I${includedir}
EOF
       fi
      fi
    fi
  fi
  [[ -f ${HOME}/.zshrc.pre* ]] && rm ${HOME}/.zshrc.pre* && cp ${DOTFILES_DIR}/.zshrc ${HOME}/.zshrc
  [[ -f ${HOME}/*brew.sh ]] && rm -rf ${HOME}/*brew.sh
  sudo cp ${DOTFILES_DIR}/etc/nfs.conf /etc/nfs.conf
popd 
