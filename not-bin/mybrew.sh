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
  # Install rosetta
  sudo softwareupdate --install-rosetta
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
  # sudo touchid
  # https://apple.stackexchange.com/questions/259093/can-touch-id-on-mac-authenticate-sudo-in-terminal
  sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
  # nfs.conf
  sudo cp ${DOTFILES_DIR}/etc/nfs.conf /etc/nfs.conf
  #
  # oh-my-zsh
  # https://github.com/ohmyzsh/ohmyzsh
  if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    [[ -f "${HOME}/.zshrc.pre*" ]] && rm ${HOME}/.zshrc.pre* && cp ${DOTFILES_DIR}/.zshrc ${HOME}/.zshrc
    source ${HOME}/.zshrc
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
    if [[ -f "${HOMEBREW_DIR}/bin/mise" ]]; then
      #
      # mise is a replacement for asdf
      eval "$(mise activate zsh)"
      mise use -g $(cat ${DOTFILES_DIR}/not-bin/mise.list)
    fi
    #
    # Lazyvim
    # Using https://www.lazyvim.org/
    if [[ ! -f ${HOME}/.config/nvim/LICENSE ]]; then
      luarocks install luacheck
      if [[ -d ${HOME}/.config/nvim ]]; then
        rm -rf ${HOME}/.config/nvim
      fi
      git clone https://github.com/LazyVim/starter ${HOME}/.config/nvim
      rsync -ar --progress --partial ${DOTFILES_DIR}/.config/nvim/ ${HOME}/.config/nvim/
    fi
    #
    # Before doing this, you need to add ssh key to github account
    if [[ ! -f "${HOME}/.ssh/id_ed25519.pub" ]]; then
      mkdir ${HOME}/.ssh
      ssh-keygen -t ed25519 -f ${HOME}/.ssh/id_ed25519 -C 'st_lim@bocchi' -a 100 -o
      ssh-add -K
      echo "Please login with a valid id on github"
      [[ -e "/Applications/Brave Browser.app" ]] && open -a /Applications/Brave Browser.app https://github.com/
      echo "We need to already have a valid ssh key installed in ssh"
      cat ${HOME}/id_ed25519.pub
      read
    fi
    if [[ ! -d "${HOME}/go/src/github.com" ]]; then
      mkdir -p ${HOME}/go/src/github.com/lysyi3m
      pushd ${HOME}/go/src/github.com/lysyi3m
        git clone https://github.com/lysyi3m/macos-terminal-themes
        open macos-terminal-themes/themes/gruvbox.terminal
      popd
    fi
    # Adding keka
    # https://github.com/aonez/Keka/wiki/Finder-Extension-on-macOS-15-Sequoia
    pluginkit -m CFBundleIdentifier=com.aone.keka.KekaFinderIntegration -vv | grep UUID | awk '{ print $3 }' | pluginkit -e "use" -u -                                                                        ─╯
    # matplotlib
    mkdir ~/.matplotlib
    cat > ~/.matplotlib/matplotlibrc <<EOF
backend: TkAgg
EOF
    if [[ "$(uname -m)" != "x86_64" ]]; then
      #
      # hdf5
      # cat > /opt/homebrew/lib/pkgconfig/hdf5.pc <<EOF
      cat > /usr/local/lib/pkgconfig/hdf5.pc <<EOF
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
  [[ -f ${HOME}/.zshrc.pre* ]] && rm ${HOME}/.zshrc.pre* && cp ${DOTFILES_DIR}/.zshrc ${HOME}/.zshrc
  [[ -f ${HOME}/*brew.sh ]] && rm -rf ${HOME}/*brew.sh
popd 
