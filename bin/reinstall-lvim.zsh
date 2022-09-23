#!/bin/zsh

LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"
LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$HOME/.config/lvim"}"
LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"$HOME/.cache/lvim"}"
DOTFILES_DIR="${HOME}/go/src/github.com/stlimtat/dotfiles"

if [[ -d "${LUNARVIM_RUNTIME_DIR}" ]]; then
  bash "${LUNARVIM_RUNTIME_DIR}/lvim/utils/installer/uninstall.sh"
  rm -rf \
    ${HOME}/.cache \
    ${HOME}/.config/nvim \
    ${HOME}/.local/share/nvim \
    ${LUNARVIM_CONFIG_DIR} \
    ${LUNARVIM_RUNTIME_DIR}
fi

REINSTALL=$1
if [[ -z "${REINSTALL}" ]]; then
  echo "Removed all lunarvim artefacts"
  exit 0
fi

LV_BRANCH=rolling \
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)

if [[ -d "${DOTFILES_DIR}" ]]; then
  rsync -ar --progress ${DOTFILES_DIR}/.config/lvim/ ${HOME}/.config/lvim/
  ln -sf ${HOME}/.local/bin/lvim ${HOME}/bin/lvim
  rsync -ar --progress $(pwd)/.config/ ${HOME}/.config/
  ${HOME}/bin/lvim +LvimUpdate +LvimCacheReset +qa
  # ${HOME}/bin/lvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  # https://github.com/wbthomason/packer.nvim/issues/502 - need to run twice
  # ${HOME}/bin/lvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
fi

