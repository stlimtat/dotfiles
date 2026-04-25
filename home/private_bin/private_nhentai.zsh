#!/bin/zsh -x

COMIC_ID=$1
GALLERY_ID=$2
GALLERY_COMIC_ID=$3
END_PAGE=$4
MANGA_NAME=$5
if [[ -z "$COMIC_ID" || -z "$GALLERY_ID" || -z "$GALLERY_COMIC_ID" || -z "$END_PAGE" || -z "$MANGA_NAME" ]]; then
  echo "Usage $0 <comic_id> <gallery_id> <gallery_comic_id> <end_page> <manga_name>"
  echo "1. get the comic id from the url - https://nhentai.net/g/<COMIC_ID>/"
  echo "2. inspect the first page image and get the gallery - https://i<GALLERY_ID>.nhentai.net/galleries/<GALLERY_COMIC_ID>/1.jpg"
  echo "3. get the number of pages from the toc page"
  echo "4. name should be any name you desire"
  exit 1
fi
MANGA_IMAGE_URL=https://i${GALLERY_ID}.nhentai.net/galleries/${GALLERY_COMIC_ID}
NHENTAI_URL=https://nhentai.net/g/${COMIC_ID}
TMPDIR=/tmp/nhentai-${COMIC_ID}
echo "Downloading from ${NHENTAI_URL}/${COMIC_ID} gallery ${MANGA_IMAGE_URL} til page ${END_PAGE} to create '${MANGA_NAME}.cbz'"

IFS=$'\012'
mkdir "$TMPDIR"
pushd "$TMPDIR"
  for (( image_no=1; image_no<=$END_PAGE; image_no++ ));
  do
    REFERER_URL=$NHENTAI_URL/${image_no}
    ZERO_PADDED_IMAGE_NO=$(printf "%03d" $image_no)
    echo curl -o ${ZERO_PADDED_IMAGE_NO}.jpg --output-dir "${TMPDIR}" --referer "$REFERER_URL" "${MANGA_IMAGE_URL}/${image_no}.jpg"
    curl -o ${ZERO_PADDED_IMAGE_NO}.jpg --output-dir "${TMPDIR}" --referer "$REFERER_URL" "${MANGA_IMAGE_URL}/${image_no}.jpg"
  done

  zip -r "${HOME}/${MANGA_NAME}.cbz" *
  ls /tmp
popd
read

# rm -rf "$TMPDIR"
