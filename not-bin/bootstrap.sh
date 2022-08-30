#!/usr/bin/env bash

function doIt() {
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude ".osx" \
    --exclude ".macos" \
    --exclude ".tokens" \
    --exclude "*.sh" \
    --exclude "*.plist" \
    --exclude "Brewfile" \
    --exclude "init/" \
    --exclude "not-bin/" \
    --exclude "README.md" \
    --exclude "LICENSE-MIT.txt" \
    -avh --no-perms \
    ${HOME}/go/src/github.com/stlimtat/dotfiles/ \
    ${HOME}/  ;
  source ~/.bash_profile;
}

# cd "$(dirname "${BASH_SOURCE}")";
pushd ${HOME}/go/src/github.com/stlimtat/dotfiles
  git pull origin master;

  if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
  else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      doIt;
    fi;
  fi;
  unset doIt;
popd 
