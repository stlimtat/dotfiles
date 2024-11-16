#!/bin/zsh
DOTFILES_DIR=${HOME}/go/src/github.com/stlimtat/dotfiles
rsync -ar --progress ${HOME}/.{aliases,bash_profile,bash_prompt,bashrc,curlrc,devenv,exports,extra,functions,gitconfig,ideavimrc,psqlrc,wgetrc,zshrc} ${DOTFILES_DIR}/
rsync -ar --progress ${HOME}/bin/*.zsh ${DOTFILES_DIR}/bin/
for s in .config/gh .config/nvim/after .config/nvim/lua .config/karabiner/karabiner.json .config/wezterm .config/zsh; do
  if [[ -d "${HOME}/${s}" ]]; then
    rsync -ar --progress --exclude="plugin" ${HOME}/${s}/ ${DOTFILES_DIR}/${s}/
  fi
  if [[ -f "${HOME}/${s}" ]]; then
    rsync -ar --progress --exclude="plugin" ${HOME}/${s} ${DOTFILES_DIR}/${s}
  fi
done
pushd ${DOTFILES_DIR}
  git commit -m "Sync with config at $(date +'%F %T%z') by $(whoami)@$(hostname)" -a
  git push
popd
