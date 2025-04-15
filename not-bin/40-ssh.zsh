#!/usr/bin/env zsh
#
# Before doing this, you need to add ssh key to github account
if [[ ! -f "${HOME}/.ssh/id_ed25519.pub" ]]; then
  mkdir ${HOME}/.ssh
  ssh-keygen -t ed25519 -f ${HOME}/.ssh/id_ed25519 -C 'st_lim@bocchi' -a 100 -o
  ssh-add -K
  echo "Please login with a valid id on github"
  [[ -e "/Applications/Brave Browser.app" ]] && open -a /Applications/Brave Browser.app https://github.com/
  echo "We need to already have a valid ssh key installed in ssh"
  cat ${HOME}/id_ed25519.pub
  read
fi
