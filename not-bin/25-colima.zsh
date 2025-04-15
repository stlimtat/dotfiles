#!/usr/bin/env zsh
# Install colima
# https://github.com/abiosoft/colima
if [[ ! -d ${HOME}/.colima ]]; then
  colima start --cpu 5 --memory 16
fi
