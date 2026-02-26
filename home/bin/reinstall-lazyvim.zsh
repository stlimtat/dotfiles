#!/bin/zsh

LAZYVIM_RUNTIME_DIR="${LAZYVIM_RUNTIME_DIR:-"$HOME/.config/nvim"}"
LAZYVIM_CONFIG_DIR="${LAZYVIM_CONFIG_DIR:-"$HOME/.config/nvim/lua"}"
DOTFILES_DIR="${HOME}/go/src/github.com/stlimtat/dotfiles"

if [[ -d "${LAZYVIM_RUNTIME_DIR}" ]]; then
  rm -rf \
    ${HOME}/.cache \
    ${HOME}/.config/nvim \
    ${HOME}/.local/share/nvim \
    ${HOME}/.local/state/nvim \
    ${LAZYVIM_CONFIG_DIR} \
    ${LAZYVIM_RUNTIME_DIR}
fi

REINSTALL=$1
if [[ -z "${REINSTALL}" ]]; then
  echo "Removed all lazyvim artefacts"
  exit 0
fi

git clone https://github.com/LazyVim/starter ~/.config/nvim

if [[ -d "${DOTFILES_DIR}" ]]; then
  rsync -ar --progress ${DOTFILES_DIR}/.config/nvim/lua/ ${HOME}/.config/nvim/lua/
fi

