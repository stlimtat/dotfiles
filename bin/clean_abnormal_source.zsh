#!/bin/zsh

pushd ${SOURCE}
  mv ${SOURCE}/.idea ${HOME}/idea-$(date +%Y%m%d)
  bazel clean
  git clean -xdf
  git gc
  git prune
  git pull
  mv ${HOME}/idea-$(date +%Y%m%d) ${SOURCE}/.idea
  ${SOURCE}/bin/venv-sync
  pip install \
    debugpy \
    flake8 \
    pip-tools \
    pylint \
    pynvim \
    spotify-dl \
    subliminal \
    vim-vint \
    virtualenv \
    youtube-dl

popd
