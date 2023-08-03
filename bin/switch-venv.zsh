#!/bin/zsh

deactivate () {
    unset -f pydoc >/dev/null 2>&1 || true

    # reset old environment variables
    # ! [ -z ${VAR+_} ] returns true if VAR is declared at all
    if ! [ -z "${_OLD_VIRTUAL_PATH:+_}" ] ; then
        PATH="$_OLD_VIRTUAL_PATH"
        export PATH
        unset _OLD_VIRTUAL_PATH
    fi
    if ! [ -z "${_OLD_VIRTUAL_PYTHONHOME+_}" ] ; then
        PYTHONHOME="$_OLD_VIRTUAL_PYTHONHOME"
        export PYTHONHOME
        unset _OLD_VIRTUAL_PYTHONHOME
    fi

    # The hash command must be called to get it to forget past
    # commands. Without forgetting past commands the $PATH changes
    # we made may not be respected
    hash -r 2>/dev/null

    if ! [ -z "${_OLD_VIRTUAL_PS1+_}" ] ; then
        PS1="$_OLD_VIRTUAL_PS1"
        export PS1
        unset _OLD_VIRTUAL_PS1
    fi

    unset VIRTUAL_ENV
    if [ ! "${1-}" = "nondestructive" ] ; then
    # Self destruct!
        unset -f deactivate
    fi
}

DEV_HOME=$HOME/dev

pushd $DEV_HOME
  VENV_CHOICES=( venv*/ )
  vared -cep "Choose the venv you want to switch to ($VENV_CHOICES): " venv_choice
popd
# echo "venv_choice: $venv_choice"
# echo "VENV_CHOICES[(i)]: ${VENV_CHOICES[(i)$venv_choice/]}"
# echo "VENV_CHOICES[(r)]: ${VENV_CHOICES[(r)$venv_choice/]}"
if [[ ${VENV_CHOICES[(i)$venv_choice/]} -gt ${#VENV_CHOICES} ]]; then
  echo "Wrong choice.  Please run again"
  exit 1
fi
echo "Valid choice - activating $venv_choice"
deactivate nondestructive
unset VIRTUAL_ENV

export VENV=$DEV_HOME/$venv_choice
source $VENV/bin/activate
export VIRTUAL_ENV=$DEV_HOME/$venv_choice
