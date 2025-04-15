#!/usr/bin/env zsh
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
