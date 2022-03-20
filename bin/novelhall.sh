#!/bin/zsh

NOVELHALL_URL=https://www.novelhall.com
NOVEL_ID=$1
if [[ ${NOVEL_ID} = "" ]]; then
    echo "No Novel ID provided"
    exit 1
fi

echo "Downloading ${NOVELHALL_URL}/${NOVEL_ID}/ as TOC"

mkdir /tmp/${NOVEL_ID}
pushd /tmp/${NOVEL_ID}
    curl -o /tmp/${NOVEL_ID}/1.tmp ${NOVELHALL_URL}/${NOVEL_ID}/

    # Parse tmp file
    sed -rn "/<a href=\"\/${NOVEL_ID}\/.*/p" /tmp/${NOVEL_ID}/1.tmp |\
        sed -e "s/^ *\t*<a href=\"\(\/${NOVEL_ID}\/.*.html\)\">Chapter \([0-9]*\).*/\2\t\1/" \
        > /tmp/${NOVEL_ID}/2.tmp

    MAX=1
    while IFS= read -r line; do
        # printf '%s\n' "$line"
        # echo $line
        CHAPTER=$(echo $line | awk '{print $1}' | xargs printf "%03d")
        CHAPTER_URL=${NOVELHALL_URL}$(echo $line | awk '{print $2}')
        echo "- Chapter ${CHAPTER} downloading ${CHAPTER_URL}"
        curl ${CHAPTER_URL} |\
            hxnormalize -x |\
            hxselect -i "div.entry-content" \
        > /tmp/${NOVEL_ID}/${CHAPTER}.tmp
        # At this point this is not a real html file
        echo "<html><head></head><body>" |\
            cat - /tmp/${NOVEL_ID}/${CHAPTER}.tmp \
            > /tmp/${NOVEL_ID}/${CHAPTER}.html
        echo "</body></html>" >> /tmp/${NOVEL_ID}/${CHAPTER}.html
        if [[ ${CHAPTER} -gt ${MAX} ]]; then
            MAX=${CHAPTER}
        fi
    done < /tmp/${NOVEL_ID}/2.tmp

    echo "<html><body><h1>Table of Contents</h1><p style=\"text-indent:0pt\">" > /tmp/${NOVEL_ID}/index.htm
    for i in {001..$MAX}; do
        echo "<a href=\"${i}.html\">Chapter ${i}</a><br/>" >> /tmp/${NOVEL_ID}/index.htm
    done
    echo "</p></body></html>" >> /tmp/${NOVEL_ID}/index.htm

    ebook-convert index.htm /tmp/${NOVEL_ID}.epub
popd
open /tmp/${NOVEL_ID}.epub
read
rm -rf /tmp/${NOVEL_ID}
