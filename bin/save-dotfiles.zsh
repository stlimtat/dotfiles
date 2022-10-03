#!/bin/zsh
DOTFILES_DIR=${HOME}/go/src/github.com/stlimtat/dotfiles
rsync -ar --progress ${HOME}/.{abnormal,aliases,bash_profile,bash_prompt,bashrc,curlrc,devenv,exports,extra,functions,gitconfig,wgetrc,zshrc} ${DOTFILES_DIR}/
rsync -ar --progress ${HOME}/bin/*.zsh ${DOTFILES_DIR}/bin/
if [[ -d "${HOME}/.config/lvim" ]]; then
  rsync -ar --progress --exclude="plugin" ${HOME}/.config/lvim/ ${DOTFILES_DIR}/.config/lvim/
fi
if [[ -d "${HOME}/.config/nvim/lua/user" ]]; then
  rsync -ar --progress --exclude="plugin" ${HOME}/.config/nvim/lua/user/ ${DOTFILES_DIR}/.config/nvim/lua/user/
fi
pushd ${DOTFILES_DIR}
  git commit -m "Sync with config at $(date +'%F %T%z') by $(whoami)@$(hostname)" -a
  git push
popd
