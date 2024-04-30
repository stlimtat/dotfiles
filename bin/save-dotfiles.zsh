#!/bin/zsh
DOTFILES_DIR=${HOME}/go/src/github.com/stlimtat/dotfiles
rsync -ar --progress ${HOME}/.{abnormal,aliases,bash_profile,bash_prompt,bashrc,curlrc,devenv,exports,extra,functions,gitconfig,ideavimrc,wezterm.lua,wgetrc,zshrc} ${DOTFILES_DIR}/
rsync -ar --progress ${HOME}/bin/*.zsh ${DOTFILES_DIR}/bin/
rsync -ar --progress ${HOME}/bin/{wezterm,}.sh ${DOTFILES_DIR}/bin/
for s in .config/gh .config/lvim .config/nvim/lua .config/karabiner .config/kitty .config/wezterm; do
  if [[ -d "${HOME}/${s}" ]]; then
    rsync -ar --progress --exclude="plugin" ${HOME}/${s}/ ${DOTFILES_DIR}/${s}/
  fi
done
pushd ${DOTFILES_DIR}
  git commit -m "Sync with config at $(date +'%F %T%z') by $(whoami)@$(hostname)" -a
  git push
popd
