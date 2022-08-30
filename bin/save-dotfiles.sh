#!/bin/zsh
DOTFILES_DIR=${HOME}/go/src/github.com/stlimtat/dotfiles
rsync -ar --progress ${HOME}/.{abnormal,aliases,bash_profile,bash_prompt,bashrc,curlrc,devenv,exports,extra,functions,gitconfig,wgetrc,zshrc} ${DOTFILES_DIR}/
for i in .config .docker bin; do
  for j in $(gfind ${DOTFILES_DIR}/${i} -type f); do
    REL_FILENAME=${j/${DOTFILES_DIR}/}
    rsync -anr --progress ${HOME}/${REL_FILENAME} ${DOTFILES_DIR}/${REL_FILENAME}
  done
done
pushd ${DOTFILES_DIR}
git commit -m "Sync with config at $(date +'%F %T%z') by $(whoami)@$(hostname)" -a
git push
popd
