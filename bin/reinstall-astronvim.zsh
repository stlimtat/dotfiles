#!/bin/zsh

NVIM_HOME=${HOME}/.config/nvim
DOTFILE_HOME=${HOME}/go/src/github.com/stlimtat/dotfiles
rm -rf ${NVIM_HOME} \
  ${HOME}/.local/share/nvim \
  ${HOME}/.config/nvim/plugin \
	${HOME}/.cache

REINSTALL=$1
if [[ "${REINSTALL}" = "" ]]; then
  echo "Just emptied astrovim"
  exit 0
fi

git clone https://github.com/AstroNvim/AstroNvim ${NVIM_HOME}
rsync -ar --progress ${DOTFILE_HOME}/.config/nvim/ ${NVIM_HOME}/
git clone https://code.mehalter.com/AstroNvim_user ${NVIM_HOME}/lua/mehalter
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
