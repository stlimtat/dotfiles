#!/usr/bin/env bash

PRODUCTS="pycharm"
MY_DATE=$(date +%Y%m%d-%H%M)
MY_BACKUP_HOME=${HOME}/src/jetbrains

performActivity() {
  IFS=$'\012'
  ACTIVITY=$1
  for product in ${PRODUCTS[@]}; do
    PROD_FILES=$(find ${HOME}/Library -iname "${product}*" 2> /dev/null)
    MY_BACKUP_DIR=${MY_BACKUP_HOME}/${product}-${MY_DATE}
    for file in ${PROD_FILES[@]}; do
      shaved_file1=${file#${HOME}\/Library/}
      shaved_file2=${shaved_file1//\//_}
      case $ACTIVITY in
        "restore")
          RESTORE_DIR=$2
          if [ -d ${MY_BACKUP_HOME}/${RESTORE_DIR} -a -f ${MY_BACKUP_HOME}/${RESTORE_DIR}/${shaved_file2} ]; then
            mv ${MY_BACKUP_HOME}/${RESTORE_DIR}/${shaved_file2} ${file}
          fi
          ;;
        "backup"|*)
          if [ ! -d ${MY_BACKUP_DIR} ]; then
            mkdir -p ${MY_BACKUP_DIR}
          fi
          mv ${file} ${MY_BACKUP_DIR}/${shaved_file2}
          ;;
      esac
    done
  done
}

if [ "$1" == "restore" -a "$2" == "" ]; then
  echo "You need to specify the directory to restore"
  ls ${MY_BACKUP_HOME}
  exit 1
fi

performActivity $@
