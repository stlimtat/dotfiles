#!/usr/bin/env zsh
# oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh
if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  [[ -f "${HOME}/.zshrc.pre*" ]] && rm ${HOME}/.zshrc.pre* && cp ${DOTFILES_DIR}/.zshrc ${HOME}/.zshrc
  rsync -ar --progress --partial ${DOTFILES_DIR}/.config/zsh/ ${HOME}/.oh-my-zsh/custom/completions/
  source ${HOME}/.zshrc
  #
  # Run init again
  [[ -f "${HOME}/.zshrc.pre*" ]] && rm ${HOME}/.zshrc.pre* && cp ${DOTFILES_DIR}/.zshrc ${HOME}/.zshrc
  source ${HOME}/.zshrc
fi
# gruvbox
# https://github.com/lysyi3m/macos-terminal-themes.git
if [[ ! -d "${HOME}/go/src/github.com/lysyi3m" ]]; then
  mkdir -p ${HOME}/go/src/github.com/lysyi3m
  pushd ${HOME}/go/src/github.com/lysyi3m
    git clone https://github.com/lysyi3m/macos-terminal-themes
    open macos-terminal-themes/themes/gruvbox.terminal
  popd
fi
