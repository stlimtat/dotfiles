#!/bin/zsh

[[ "$(type deactivate | grep function)" != "" ]] && deactivate()
[[ "$(python --version | grep '3.8.' )" == "" ]] && ${SOURCE}/tools/dev/venv-activate
pip list --outdated |\ 
  cut -w -f 1 |\
  gsed 1,2d |\
  xargs pip install --upgrade

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
popd

