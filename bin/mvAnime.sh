#!/usr/local/bin/bash

#MOVIE_DIR=/Volumes/downloads
MOVIE_DIR=/Users/st_lim/Public
#MOVIE_DIR=/Volumes/STLIM_2TB/archive/Movies
ANIME_DIR=${MOVIE_DIR}/Anime
#ANIME_DIR=${MOVIE_DIR}/../Anime

ANIME_PREFIX=('HorribleSubs' 'DeadFish' 'PAS' 'UTW')

[ ! -d ${ANIME_DIR} ] && mkdir -p ${ANIME_DIR} 
for i in {0..9} {A..Z}; do
				ANIME_I=${ANIME_DIR}/${i}
				for j in ${ANIME_PREFIX[@]}; do
								cd ${MOVIE_DIR}
								for k in \[${j}\]\ ${i}*.mkv \[${j}\]_${i}*.mkv; do
												if [ -f "${k}" ]; then
																l="${k/ - [0-9][0-9]* \[720p\].mkv/}"
																[ ! -d "${ANIME_I}/${l}" ] && mkdir -p "${ANIME_I}/${l}"
																mv "${k}" "${ANIME_I}/${l}"
												fi
								done
								for k in \[${j}\]\ ${i}*.mp4 \[${j}\]_${i}*.mp4; do
												if [ -f "${k}" ]; then
																l="${k/ - [0-9][0-9]* \[720p\]\[AAC\].mp4/}"
																[ ! -d "${ANIME_I}/${l}" ] && mkdir -p "${ANIME_I}/${l}"
																mv "${k}" "${ANIME_I}/${l}"
												fi
								done
				done
done