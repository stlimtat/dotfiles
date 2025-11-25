#!/bin/zsh
DOTFILES_DIR=${HOME}/go/src/github.com/stlimtat/dotfiles
rsync -ar --progress \
  ${HOME}/.{aliases,bash_profile,bash_prompt,bashrc,curlrc,default-python-packages,devenv,exports,extra,functions,gitconfig,ideavimrc,kmonad.kbd,psqlrc,wgetrc,zshrc} \
  ${DOTFILES_DIR}/
rsync -ar --progress \
  ${HOME}/.oh-my-zsh/custom/ \
  ${DOTFILES_DIR}/omz/
rsync -ar --progress ${HOME}/bin/*.zsh ${DOTFILES_DIR}/bin/
# Sync the settings for vscode and cursor and antigravity
for s in Antigravity Code Cursor; do
  rsync -ar --progress \
    ${HOME}/Library/Application\ Support/${s}/User/{settings.json,keybindings.json} \
    ${DOTFILES_DIR}/Library/Application\ Support/${s}/User/
done
# rsync -ar --progress \
#   ${HOME}/Library/Application\ Support/{antigravity,Code,Cursor}/User/{settings.json,keybindings.json} \
#   ${DOTFILES_DIR}/Library/Application\ Support/User/
mise list | cut -d' ' -f1 > ${DOTFILES_DIR}/build/mise.list
for s in .config/gh .config/nvim/after .config/nvim/lua .config/karabiner/karabiner.json .config/wezterm .config/zsh .ssh/config; do
  if [[ -d "${HOME}/${s}" ]]; then
    rsync -ar --progress --exclude="plugin" \
      ${HOME}/${s}/ ${DOTFILES_DIR}/${s}/
  fi
  if [[ -f "${HOME}/${s}" ]]; then
    rsync -ar --progress --exclude="plugin" \
      ${HOME}/${s} ${DOTFILES_DIR}/${s}
  fi
done
pushd ${DOTFILES_DIR}
  git commit -m "Sync with config at $(date +'%F %T%z') by $(whoami)@$(hostname)" -a
  git push
popd
