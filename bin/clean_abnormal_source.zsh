#!/bin/zsh

VENV=$HOME/dev/venv
start_time=$(gdate +%s%3N)
echo "Running venv-activate...${start_time}ms"
[[ "$(type deactivate | grep function)" != "" ]] && echo "Running venv-activate...${start_time}ms...deactivate" && deactivate() 2>&1 
[[ "$(python --version | grep '3.8.')" == "" ]] && echo "Running venv-activate...${start_time}ms...activate" && source $VENV/bin/activate
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Running venv-activate...${end_time}ms...${time_taken}ms...Done"

# start_time=$(gdate +%s%3N)
# echo "Running pip outdated...${start_time}ms"
# pip list --outdated |\ 
#   cut -w -f 1 |\
#   gsed 1,2d |\
#   xargs pip install --upgrade
# end_time=$(gdate +%s%3N)
# time_taken=$((end_time - start_time))
# echo "Running pip outdated...${end_time}ms...${time_taken}ms...Done"

pushd ${SOURCE}
  if [[ -d "${SOURCE}/.idea" ]]; then
    mv ${SOURCE}/.idea ${HOME}/idea-$(date +%Y%m%d)
  fi
  if [[ -f "${SOURCE}/src/js/abnormal/daffodil-playwright/.env*" ]]; then
    for i in ${SOURCE}/src/js/abnormal/daffodil-playwright/.env*; do
      mv ${i} ${HOME}/$(basename $i)-$(date +%Y%m%d)
    done
  fi
  start_time=$(gdate +%s%3N)
  echo "Running bazel clean...${start_time}ms"
  bazel clean
  end_time=$(gdate +%s%3N)
  time_taken=$((end_time - start_time))
  echo "Running bazel clean...${end_time}ms...${time_taken}ms...Done"

  start_time=$(gdate +%s%3N)
  echo "Running git clean...${start_time}ms"
  git clean -xdf
  git gc
  git prune
  end_time=$(gdate +%s%3N)
  time_taken=$((end_time - start_time))
  echo "Running git clean...${end_time}ms...${time_taken}ms...Done"

  start_time=$(gdate +%s%3N)
  echo "Running git pull...${start_time}ms"
  git pull
  end_time=$(gdate +%s%3N)
  time_taken=$((end_time - start_time))
  echo "Running git pull...${end_time}ms...${time_taken}ms...Done"

  if [[ -d "${HOME}/.idea-$(date +%Y%m%d)" ]]; then
    mv ${HOME}/idea-$(date +%Y%m%d) ${SOURCE}/.idea
  fi
  if [[ -d "${HOME}/.env-$(date +%Y%m%d)" ]]; then
    for i in ${HOME}/.env*; do
      env_file_with_date = $(basename $i)
      env_file = ${env_file_with_date/-$(date +%Y%m%d)/}
      mv ${HOME}/${i} ${SOURCE}/src/js/abnormal/daffodil-playwright/${env_file}
    done
  fi
  start_time=$(gdate +%s%3N)
  echo "Running venv-sync...${start_time}ms"
  ${SOURCE}/bin/venv-sync
  end_time=$(gdate +%s%3N)
  time_taken=$((end_time - start_time))
  echo "Running venv-sync...${end_time}ms...${time_taken}ms...Done"
popd

