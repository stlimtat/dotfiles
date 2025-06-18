#!/usr/bin/env zsh
# 
# DOTFILES_DIR setting up
SCRIPT_DIR=$(dirname ${0})
if [[ "${SCRIPT_DIR}" = "." ]]; then
  SCRIPT_DIR=$(pwd)
fi
DOTFILES_DIR=$(dirname $SCRIPT_DIR)
export DOTFILES_DIR
# Check if installing for dev environment
echo -n "Are you setting up a dev machine (Y|n)?"
read DEV_SETUP
[[ "${DEV_SETUP}" =~ "[nN]" ]] && unset DEV_SETUP
#
# Install command-line tools using Homebrew.
HOMEBREW_DIR="/usr/local/Homebrew"
if [[ "$(uname -m)" != "x86_64" ]]; then
  HOMEBREW_DIR="/opt/homebrew"
  # Install rosetta
  sudo softwareupdate --install-rosetta
fi
export HOMEBREW_DIR

for file in ${DOTFILES_DIR}/build/[0-9][0-9]-*.zsh; do
  # Skip the script itself
  if [[ "${file}" == "${0}" ]]; then
    continue
  fi
  # Skip the script if it is not executable
  if [[ ! -x "${file}" ]]; then
    continue
  fi
  # Skip the script if it is not a file
  if [[ ! -f "${file}" ]]; then
    continue
  fi
  # Run the script
  echo "Running ${file}"
  /bin/zsh "${file}"
done

