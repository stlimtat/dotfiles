#!/usr/bin/env zsh
#
# Install mise
if [[ -f "${HOMEBREW_DIR}/bin/mise" ]]; then
  #
  # mise is a replacement for asdf
  eval "$(mise activate zsh)"
  mise use -g $(cat ${DOTFILES_DIR}/build/mise.list)
fi
