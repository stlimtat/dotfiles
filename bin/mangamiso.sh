#!/bin/zsh -x

MANGAMISO_URL=https://mangamiso.net
MANGAMISO_MANGA_URL=$MANGAMISO_URL/mangas
MANGA=$1

if [[ $MANGA = "" ]]; then
    echo "manga $MANGA not defined"
    exit 1
fi

# Downloading TOC
TMPDIR=/tmp/mangamiso-$MANGA

mkdir $TMPDIR
pushd $TMPDIR
    curl -o $TMPDIR/a.json \
        $MANGAMISO_MANGA_URL/$MANGA/get-manga-chapters-12345\?page\=1\&perPage\=200\&sort\=1
    TOTAL_CHAPTERS=$(cat $TMPDIR/a.json | jq '.chapters.totalChapters')
    TOTAL_LOOPS=$((TOTAL_CHAPTERS-1))
    for i in $(seq 0 $TOTAL_LOOPS); do
        CHAPTER=$(cat $TMPDIR/a.json | jq ".chapters.chapters[$i].chapterNum")
        CHAPTER_URL=$(cat $TMPDIR/a.json | jq ".chapters.chapters[$i].pathName" | sed -e 's/"//g')

        curl -o $TMPDIR/$CHAPTER.json \
            $MANGAMISO_MANGA_URL/$MANGA/$CHAPTER_URL
        TOTAL_PAGES=$(cat $TMPDIR/$CHAPTER.json | jq '.chapter.pages | length')
        TOTAL_PAGE_LOOPS=$((TOTAL_PAGES - 1))
        for page in $(seq 0 $TOTAL_PAGE_LOOPS); do
            IMAGE_PATH=$(cat $TMPDIR/$CHAPTER.json | jq ".chapter.pages[$page].path" | sed -e 's/"//g')
            IMAGE_FILENAME=$(printf "%03d-%03d" $CHAPTER $page).webp
            echo "Downloading $IMAGE_FILENAME from $MANGAMISO_URL$IMAGE_PATH"
            curl -o $TMPDIR/$IMAGE_FILENAME \
                $MANGAMISO_URL$IMAGE_PATH
        done
    done

    rm *.json
    zip -r /tmp/$MANGA.cbz *.webp
popd
read
w

rm -rf $TMPDIR
