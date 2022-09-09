#!/bin/zsh

pushd ${SOURCE}
  mv ${SOURCE}/.idea ${HOME}/idea-$(date +%Y%m%d)
  bazel clean
  git clean -xdf
  git gc
  git prune
  git pull
  mv ${HOME}/idea-$(date +%Y%m%d) ${SOURCE}/.idea
popd
