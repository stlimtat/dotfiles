#!/bin/zsh

pushd ${SOURCE}
  mv ${SOURCE}/.idea ${HOME}/idea-$(date +%Y%m%d)
  for i in ${SOURCE}/src/js/abnormal/daffodil-playwright/.env*; do
    mv ${i} ${HOME}/$(basename $i)-$(date +%Y%m%d)
  done
  bazel clean
  git clean -xdf
  git gc
  git prune
  git pull
  mv ${HOME}/idea-$(date +%Y%m%d) ${SOURCE}/.idea
  for i in ${HOME}/.env*; do
    env_file_with_date = $(basename $i)
    env_file = ${env_file_with_date/-$(date +%Y%m%d)/}
    mv ${HOME}/${i} ${SOURCE}/src/js/abnormal/daffodil-playwright/${env_file}
  done
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
