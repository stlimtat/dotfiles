#!/usr/local/bin/bash

DOWNLOAD_DIR=/Volumes/downloads
ANIME_DIR=${DOWNLOAD_DIR}/Anime
HOLLY_DIR=${DOWNLOAD_DIR}/Hollywood
KIDS_DIR=${DOWNLOAD_DIR}/kids

ANIME_PREFIX=('HorribleSubs' 'DeadFish' 'PAS' 'UTW' 'Anon' 'anon' 'Over-Time')

move_file_to_dir() {
  FILE_NAME=$1
  MY_DIR=$2
  MOVIE_NAME=$(basename -- $FILE_NAME)
  FIRST_CHAR=${MOVIE_NAME:0:1}
  THE_DETECT=${MOVIE_NAME:0:3}
  THE_DETECT_UPPPER=$(echo ${THE_DETECT} | tr '[:lower:]' '[:upper:]')
  if [ "$THE_DETECT_UPPPER" = "THE" ]; then
    FIRST_CHAR=${MOVIE_NAME:4:1}
  fi
  [ ! -d ${MY_DIR}/${FIRST_CHAR}/ ] && mkdir ${MY_DIR}/${FIRST_CHAR}
  mv ${FILE_NAME} ${MY_DIR}/${FIRST_CHAR}/
  mv ${FILE_NAME/.mp4/.srt} ${MY_DIR}/${FIRST_CHAR}/
  mv ${FILE_NAME/.mkv/.srt} ${MY_DIR}/${FIRST_CHAR}/
}

move_anime_to_dir() {
  [ ! -d ${ANIME_DIR} ] && mkdir -p ${ANIME_DIR} 
  for i in {0..9} {A..Z}; do
    ANIME_I=${ANIME_DIR}/${i}
    for j in ${ANIME_PREFIX[@]}; do
      cd ${DOWNLOAD_DIR}
      for k in \[${j}\]\ ${i}*.mkv \[${j}\]_${i}*.mkv \[${j}\]\ ${i}*.mp4 \[${j}\]_${i}*.mp4; do
        if [ -f "${k}" ]; then
          l="${k%% - [0-9][0-9]*}"
          [ ! -d "${ANIME_I}/${l}" ] && mkdir -p "${ANIME_I}/${l}"
          mv "${k}" "${ANIME_I}/${l}"
        fi
      done
    done
  done
}

move_to_holly() {
  count=-1
  for j in $(gfind ${DOWNLOAD_DIR} -maxdepth 1 -type d -regex '.*\ ([0-9]+)'); do
        count=$((count + 1))
        MOVIES_BRACKET[$count]=${j}
  done
  echo ${MOVIES_BRACKET[*]}
  IFS=$'\012'
  
  for i in \
    ${DOWNLOAD_DIR}/*\[YTS.*\] \
    ${MOVIES_BRACKET[*]} \
    ${DOWNLOAD_DIR}/*.BluRay.* \
    ${DOWNLOAD_DIR}/*.WEBRip.*; do
    for j in $(gfind ${i} -name "*.mp4" -o -name "*.mkv" -o -name "*.avi"); do
      subliminal download -l en -s "${j}"
  		move_file_to_dir "${j}" "${HOLLY_DIR}"
      if [ ! -f "${j}" ]; then
        rm -rf "${i}"
      fi
    done
  done
}

get_dir_subs() {
  MY_DIR=$1
  IFS=$'\012'
  for i in $(gfind ${MY_DIR} -maxdepth 2 -name "*.mp4" -o -name "*.mkv" -o -name "*.avi"); do
    MOVIE_NAME=$(basename -- $i)
    SRT_FILE=${MOVIE_NAME%.*}.srt
    if [ -f ${SRT_FILE} ]; then
      subliminal download -l en -s "${i}"
    	move_file_to_dir "${i}" "${MY_DIR}"
    fi
  done
}

move_anime_to_dir
move_to_holly
get_dir_subs ${KIDS_DIR}
get_dir_subs ${HOLLY_DIR}
