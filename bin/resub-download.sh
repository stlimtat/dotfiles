#!/usr/local/bin/bash

IFS=$'\012'
DOWN_DIR=/Volumes/downloads
HW_DIR=${DOWN_DIR}/Hollywood

for i in {A..Z}; do
  for j in ${HW_DIR}/${i}/*.{mp4,mkv,avi}; do 
    echo ${j/%????/}; 
    if [ ! -f "${j/%????/}.srt" ]; then 
      subliminal download -l en -s ${j}
    fi
  done
done