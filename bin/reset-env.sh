#!/usr/bin/env bash

# Install goenv
reset_goenv() {
  eval "$(goenv init -)"
  GO_VER="$(goenv install --list | grep -v [a-z] | grep 1.11 | tail -n1 | awk '{ print $1 }')"
  if [ ! -d ${HOME}/.goenv/versions/${GO_VER} ]; then
    goenv install ${GO_VER}
    goenv global ${GO_VER}
  fi
}

# Source for jenv from ~/.extra
reset_java() {
  for i in 1.6 1.7 1.8 10 11 12; do
    if [ -d /Library/Java/JavaVirtualMachines/$( ls /Library/Java/JavaVirtualMachines | grep ${i} )/Contents/Home ]; then
      jenv add /Library/Java/JavaVirtualMachines/$( ls /Library/Java/JavaVirtualMachines | grep ${i} )/Contents/Home
    fi
  done
}

# Install pyenv
reset_python() {
  eval "$(pyenv init -)"
  PY_VER="$(pyenv install --list | grep -v [a-z] | grep 3.7 | tail -n1 | awk '{ print $1 }')"
  if [ ! -d ${HOME}/.pyenv/versions/${PY_VER} ]; then
    pyenv install ${PY_VER}
    pyenv global ${PY_VER}
    eval "$(pyenv init -)"
    curl -o- https://bootstrap.pypa.io/get-pip.py | python -
    pip install --upgrade pip setuptools
  fi
}

# Install Renv
# https://github.com/viking/Renv
reset_r() {
  pushd ${HOME}/.Renv
    git pull
    pushd ${HOME}/.Renv/plugins/R-build
      git pull
    popd
  popd
  eval "$(${HOME}/.Renv/bin/Renv init -)"
  R_VER="$(${HOME}/.Renv/bin/Renv install --list | grep -v [a-z] | sort -n | tail -n1 | awk '{ print $1 }')"
  if [ ! -d {HOME}/.Renv/versions/${R_VER} ]; then
    $( CONFIGURE_OPTS="--without-x --includedir=$(brew --prefix xz)/include --enable-memory-profiling" \
      Renv install --keep ${R_VER} 2> /dev/null ) \
      || true
    pushd ${HOME}/.Renv/sources/${R_VER}/R-${R_VER}
      ./configure --prefix=${HOME}/.Renv/versions/${R_VER} --without-x --includedir=$(brew --prefix xz)/include --enable-memory-profiling
      make
      make install
    popd
    rm -rf ${HOME}/.Renv/sources/${R_VER}/R-${R_VER}
    Renv global ${R_VER}
  fi
}

# Install rbenv
reset_ruby() {
  eval "$(rbenv init -)"
  RB_VERSION=$(rbenv install -l | grep -v [a-z] | sort -n | tail -n1 | awk '{ print $1 }')
  if [ ! -d ${HOME}/.rbenv/versions/${RB_VERSION} ]; then
    rbenv install ${RB_VERSION}
    rbenv global ${RB_VERSION}
    eval "$(rbenv init -)"
  fi
}

# The main program lah
OPT=$1
case $OPT in
  "go")
    echo "Resetting Go"
    reset_go
    ;;
  "java")
    echo "Resetting Java"
    reset_java
    ;;
  "python")
    echo "Resetting Python"
    reset_python
    ;;
  "r")
    echo "Resetting R"
    reset_r
    ;;
  "ruby")
    echo "Running Ruby"
    reset_ruby
    ;;
  "all"|*)
    echo "Running Everything"
    reset_goenv
    reset_java
    reset_pyenv
    reset_r
    reset_ruby
    ;;
esac
