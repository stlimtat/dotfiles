#!/usr/local/bin/bash

MOVIE_DIR=/Volumes/downloads
ANIME_DIR=${MOVIE_DIR}/Anime

ANIME_PREFIX=('HorribleSubs' 'DeadFish' 'PAS' 'UTW' 'Anon' 'anon')

[ ! -d ${ANIME_DIR} ] && mkdir -p ${ANIME_DIR} 
for i in {0..9} {A..Z}; do
				ANIME_I=${ANIME_DIR}/${i}
				for j in ${ANIME_PREFIX[@]}; do
								cd ${MOVIE_DIR}
								for k in \[${j}\]\ ${i}*.mkv \[${j}\]_${i}*.mkv \[${j}\]\ ${i}*.mp4 \[${j}\]_${i}*.mp4; do
												if [ -f "${k}" ]; then
																l="${k%% - [0-9][0-9]*}"
																[ ! -d "${ANIME_I}/${l}" ] && mkdir -p "${ANIME_I}/${l}"
																mv "${k}" "${ANIME_I}/${l}"
												fi
								done
				done
done

YEAR=$(date +%Y)
YEAR_PLUS=$(($YEAR + 1))
YEAR_LIST=$(eval echo {1950..$YEAR_PLUS})
count=-1
for j in $YEAR_LIST; do
				MOVIES_YEAR=${MOVIE_DIR}/*\($j\)
				if [ -d ${MOVIES_YEAR[0]} ]; then
								for k in ${MOVIES_YEAR[*]}; do
												count=$((count + 1))
												MOVIES_BRACKET[$count]=${k}
								done
				fi
done
IFS=$'\012'
for i in ${MOVIE_DIR}/*\[YTS.A*\] ${MOVIES_BRACKET[*]}; do
				for j in `find ${i} -name "*.mp4" -o -name "*.mkv"`; do
								subliminal download -l en -s "${j}"
								mv ${j} ${MOVIE_DIR}/Hollywood
								mv ${j/.mp4/.srt} ${MOVIE_DIR}/Hollywood
								mv ${j/.mkv/.srt} ${MOVIE_DIR}/Hollywood
								if [ ! -f "${j}" ]; then
												rm -rf "${i}"
								fi
				done
done