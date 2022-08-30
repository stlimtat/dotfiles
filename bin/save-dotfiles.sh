#!/bin/zsh
DOTFILES_DIR=${HOME}/go/src/github.com/stlimtat/dotfiles
rsync -ar --progress ${HOME}/.{abnormal,aliases,bash_profile,bash_prompt,bashrc,curlrc,devenv,exports,extra,functions,gitconfig,wgetrc,zshrc} ${DOTFILES_DIR}/
for i in .config .docker bin; do
  rsync -ar --progress ${HOME}/${i}/ ${DOTFILES_DIR}/${i}/
done
pushd ${DOTFILES_DIR}
git commit -m "Sync with config at $(date +'%F %T%z') by $(whoami)@$(hostname)"
git push
popd
