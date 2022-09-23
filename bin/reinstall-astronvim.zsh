#!/bin/zsh

NVIM_HOME=${HOME}/.config/nvim
rm -rf ${NVIM_HOME} \
	${HOME}/.cache
git clone https://github.com/AstroNvim/AstroNvim ${NVIM_HOME}
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
