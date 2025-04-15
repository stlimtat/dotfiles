#!/usr/bin/env zsh
#
# DOTFILES_DIR setting up
SCRIPT_DIR=$(dirname ${0})
if [[ "${SCRIPT_DIR}" = "." ]]; then
  SCRIPT_DIR=$(pwd)
fi
DOTFILES_DIR=$(dirname $SCRIPT_DIR)
# Copy files
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
popd
source ~/.zshrc
# nfs.conf
sudo cp ${DOTFILES_DIR}/etc/nfs.conf /etc/nfs.conf
[[ -f ${HOME}/.zshrc.pre* ]] && rm ${HOME}/.zshrc.pre* && cp ${DOTFILES_DIR}/.zshrc ${HOME}/.zshrc
[[ -f ${HOME}/*brew.sh ]] && rm -rf ${HOME}/*brew.sh

