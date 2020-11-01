#!/usr/local/bin/bash

DOWNLOAD_DIR=/Volumes/Public
ANIME_DIR=${DOWNLOAD_DIR}/Anime
HOLLY_DIR=${DOWNLOAD_DIR}/Hollywood
KIDS_DIR=${DOWNLOAD_DIR}/kids

ANIME_PREFIX=('HorribleSubs' 'DeadFish' 'PAS' 'UTW' 'Anon' 'anon' 'Over-Time' 'FLsnow' 'Some-Stuffs' 'AnimeRG' 'Judas' 'Anime Time' 'ASW')

move_file_to_dir() {
  FULL_FILENAME=$1
  MY_DIR=$2
  # https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash/965072#965072
  MOVIE_FILENAME="${FULL_FILENAME##*/}"
  MOVIE_DIR="${FULL_FILENAME:0:${#FULL_FILENAME} - ${#MOVIE_FILENAME}}"
  MOVIE_FILEBASE="${MOVIE_FILENAME%.[^.]*}"
  SRT_FILE="${MOVIE_DIR}${MOVIE_FILEBASE}.srt"
  FIRST_CHAR=${MOVIE_FILENAME:0:1}
  # Removing the "The" section of the filename
  if [ "${FIRST_CHAR}" == "T" ]; then
    THE_DETECT=${MOVIE_FILENAME:0:3}
    THE_DETECT_UPPPER=$(echo ${THE_DETECT} | tr '[:lower:]' '[:upper:]')
    if [ "$THE_DETECT_UPPPER" = "THE" ]; then
      FIRST_CHAR=${MOVIE_FILENAME:4:1}
    fi
  fi
  # End
  [ ! -d ${MY_DIR}/${FIRST_CHAR}/ ] && mkdir ${MY_DIR}/${FIRST_CHAR}
  mv ${FULL_FILENAME} ${MY_DIR}/${FIRST_CHAR}/
  mv ${SRT_FILE} ${MY_DIR}/${FIRST_CHAR}/ 2>/dev/null
}

move_anime_to_dir() {
  [ ! -d ${ANIME_DIR} ] && mkdir -p ${ANIME_DIR}
  IFS=$'\012'
  for i in {0..9} {A..Z}; do
    ANIME_I=${ANIME_DIR}/${i}
    for j in ${ANIME_PREFIX[@]}; do
      cd ${DOWNLOAD_DIR}
      for k in \[${j}\]\ ${i}*.mkv \[${j}\]_${i}*.mkv \[${j}\]\ ${i}*.mp4 \[${j}\]_${i}*.mp4; do
        if [ -f "${k}" ]; then
          a="${k//_/ }"
          b="${a%% - [0-9][0-9]*}"
          a="${b%%) [0-9][0-9]* (*}"
          b="${a%% - [0-9]* \[*}"
          x="${b%%- S[0-9][0-9]E[0-9][0-9]*}"
          [ ! -d "${ANIME_I}/${x}" ] && mkdir -p "${ANIME_I}/${x}"
          mv "${k}" "${ANIME_I}/${x}/"
        fi
      done
    done
  done
}

move_to_holly() {
  IFS=$'\012'
  count=-1
  for j in $(gfind ${DOWNLOAD_DIR} -maxdepth 1 -type d -regex '.*\ ([0-9]+)'); do
        count=$((count + 1))
        MOVIES_BRACKET[$count]=${j}
  done
  echo ${MOVIES_BRACKET[*]}

  for i in \
    ${DOWNLOAD_DIR}/*\[YTS.*\] \
    ${MOVIES_BRACKET[*]} \
    ${DOWNLOAD_DIR}/*.BluRay.* \
    ${DOWNLOAD_DIR}/*.WEBRip.*; do
    for j in $(gfind ${i} -name "*.mp4" -o -name "*.mkv" -o -name "*.avi" 2> /dev/null); do
      # https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash/965072#965072
      MOVIE_FILENAME="${j##*/}"
      MOVIE_DIR="${j:0:${#j} - ${#MOVIE_FILENAME}}"
      MOVIE_FILEBASE="${MOVIE_FILENAME%.[^.]*}"
      SRT_FILE="${MOVIE_DIR}${MOVIE_FILEBASE}.srt"
      if [ -f "${SRT_FILE}" ]; then
        SRT_SIZE=$(gstat -c%s "${SRT_FILE}")
        if [ ${SRT_SIZE} -lt 500 ]; then
          rm -rf "${SRT_FILE}"
        fi
      fi
      subliminal download -l en -s "${j}"
  		move_file_to_dir "${j}" "${HOLLY_DIR}"
      rm -rf "${i}"
    done
  done
}

get_dir_subs() {
  MY_DIR=$1
  IFS=$'\012'
  for i in $(gfind ${MY_DIR} -maxdepth 2 -name "*.mp4" -o -name "*.mkv" -o -name "*.avi"); do
    # https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash/965072#965072
    MOVIE_FILENAME="${i##*/}"
    MOVIE_DIR="${i:0:${#i} - ${#MOVIE_FILENAME}}"
    MOVIE_FILEBASE="${MOVIE_FILENAME%.[^.]*}"
    SRT_FILE="${MOVIE_DIR}${MOVIE_FILEBASE}.srt"
    if [ ! -f "${SRT_FILE}" ]; then
      subliminal download -l en -s "${i}"
    	move_file_to_dir "${i}" "${MY_DIR}"
    fi
  done
  for i in $(gfind ${MY_DIR} -name "*.srt" -size 1000c); do
    rm -rf ${i}
    subliminal download -l en -s "${i/.srt/.mp4}"
  done
}

if [ ! -d ${DOWNLOAD_DIR} ]; then
  echo "${DOWNLOAD_DIR} not found"
  exit 1
fi

OPTS=$1
move_anime_to_dir
move_to_holly
case $OPTS in
  sub)
    #get_dir_subs ${KIDS_DIR}
    get_dir_subs ${HOLLY_DIR}
    ;;
esac

