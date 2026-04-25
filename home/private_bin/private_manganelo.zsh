#!/bin/zsh -x

MANGANELO_URL=https://chap.manganelo.com
MANGANELO_MANGA_URL=$MANGANELO_URL/manga-
MANGA=$1

if [[ $MANGA = "" ]]; then
    echo "manga $MANGA not defined"
    exit 1
fi

START_CHAPTER=0
LATEST_CHAPTER=0
TITLE=$MANGA
if [[ $2 != "" ]]; then
    START_CHAPTER=$(echo "$2 * 10" | bc | xargs printf "%04.0f")
fi

# Downloading TOC
TMPDIR=/tmp/manganelo-$MANGA

[ ! -d $TMPDIR ] && mkdir $TMPDIR
pushd $TMPDIR
    curl -o $TMPDIR/a.tmp $MANGANELO_MANGA_URL$MANGA
    hxnormalize -x $TMPDIR/a.tmp |\
        hxselect -i "ul.row-content-chapter" |\
        gsed -e '/.*<li.*/N;s/\n */ /g' \
          -e 's/^.*href="\([^"]*\)\"[^>]*>.*Chapter \([0-9.]*\)[^<]*<\/a>.*/\2 \1/g' \
          -e '/.*ul.*/d' \
          -e '/^$/d' \
          -e '/^ *<.*>.*$/d' \
        > $TMPDIR/b.tmp
    TITLE=$(hxnormalize -x $TMPDIR/a.tmp | hxselect "h1" | sed -e "s/<[^>]*>//g")
    while IFS= read -r line; do
        CHAPTER_RAW=$(echo $line | awk '{print $1}')
        CHAPTER=$(echo "$CHAPTER_RAW * 10" | bc | xargs printf "%04.0f")
        CHAPTER_URL=$(echo $line | awk '{print $2}')
        if [[ $((10#$CHAPTER)) -gt $((10#$LATEST_CHAPTER)) ]]; then
          LATEST_CHAPTER=$CHAPTER
        fi
        echo "- Chapter ${CHAPTER} downloading ${CHAPTER_URL}"
        if [[ $((10#$CHAPTER)) -ge $((10#$START_CHAPTER)) ]]; then
            curl -o $TMPDIR/${CHAPTER}-a.tmp \
                ${CHAPTER_URL}
            hxnormalize -x $TMPDIR/${CHAPTER}-a.tmp |\
                hxselect -i "div.container-chapter-reader" |\
                hxnormalize -x |\
                sed -e 's/^.*src="\([^"]*\)".*/\1/' \
                -e '/.*div.*/d' \
                -e '/^$/d' \
                -e '/^[^h][^t].*/d' \
                -e 's/.*\/\([0-9]*\)\.\([a-zA-Z]\{3\}\)/\1 \2 &/' \
            > $TMPDIR/${CHAPTER}.tmp
            while IFS= read -r image; do
                IMAGE_ID=$(echo $image | awk '{print $1}' | xargs printf "%04d")
                IMAGE_EXT=$(echo $image | awk '{print $2}')
                IMAGE_URL=$(echo $image | awk '{print $3}')
                echo "- Downloading page ${IMAGE_ID} from ${IMAGE_URL}" 
                curl -o $TMPDIR/$CHAPTER-$IMAGE_ID.$IMAGE_EXT \
                    --referer $MANGANELO_URL \
                    $IMAGE_URL
            done < $TMPDIR/${CHAPTER}.tmp
        fi
    done < $TMPDIR/b.tmp

    zip -r "/tmp/${TITLE}-${MANGA}-${START_CHAPTER}-${LATEST_CHAPTER}.cbz" *.jpg *.png
popd
read
rm -rf $TMPDIR
