#!/bin/zsh -x

# Step 1: find div.vg_r_data in page
# <div class="d-none vg-r-data" data-chapter_num="187103" data-chapter-type="3" data-chapter-domain="https://feifei.mhtupian.com" data-chapter-key="manhuacat2021"></div>
# Step 2: find img_data in page
# let img_data = "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"
# Step 3: Run LZString.decompressFromBase64(img_data)
# Returns 'img/8222/171702/seemh-001-2a8b.jpg,img/8222/171702/seemh-002-5f18.jpg,img/8222/171702/seemh-003-0c77.jpg,...'

MANGA="[Cuvie] Dorothea - Majo No Tetsutsui 06"
REFERER_URL=https://www.manhuafei.com/manhua/5227/208225.html
MANGA_LIST_STR="img/2289/19532/seemh-001-cde9.jpg,img/2289/19532/seemh-002-1f29.jpg,img/2289/19532/seemh-002-1f29b.jpg,img/2289/19532/seemh-003-bfb4.jpg,img/2289/19532/seemh-003-bfb4b.jpg,img/2289/19532/seemh-004-d052.png,img/2289/19532/seemh-004-d052b.png,img/2289/19532/seemh-005-64c2.png,img/2289/19532/seemh-005-64c2b.png,img/2289/19532/seemh-006-1057.png,img/2289/19532/seemh-006-1057b.png,img/2289/19532/seemh-007-b8af.png,img/2289/19532/seemh-007-b8afb.png,img/2289/19532/seemh-008-e08d.png,img/2289/19532/seemh-008-e08db.png,img/2289/19532/seemh-009-48a9.png,img/2289/19532/seemh-009-48a9b.png,img/2289/19532/seemh-010-42e8.png,img/2289/19532/seemh-010-42e8b.png,img/2289/19532/seemh-011-91ae.png,img/2289/19532/seemh-011-91aeb.png,img/2289/19532/seemh-012-4593.png,img/2289/19532/seemh-012-4593b.png,img/2289/19532/seemh-013-ec35.png,img/2289/19532/seemh-013-ec35b.png,img/2289/19532/seemh-014-f695.png,img/2289/19532/seemh-014-f695b.png,img/2289/19532/seemh-015-00d9.png,img/2289/19532/seemh-015-00d9b.png,img/2289/19532/seemh-016-0043.png,img/2289/19532/seemh-016-0043b.png,img/2289/19532/seemh-017-ee56.png,img/2289/19532/seemh-017-ee56b.png,img/2289/19532/seemh-018-5b07.png,img/2289/19532/seemh-018-5b07b.png,img/2289/19532/seemh-019-7135.png,img/2289/19532/seemh-019-7135b.png,img/2289/19532/seemh-020-30b0.png,img/2289/19532/seemh-020-30b0b.png,img/2289/19532/seemh-021-8e13.png,img/2289/19532/seemh-021-8e13b.png,img/2289/19532/seemh-022-f7f4.png,img/2289/19532/seemh-022-f7f4b.png,img/2289/19532/seemh-023-fc59.png,img/2289/19532/seemh-023-fc59b.png,img/2289/19532/seemh-024-b8df.png,img/2289/19532/seemh-024-b8dfb.png,img/2289/19532/seemh-025-c51f.png,img/2289/19532/seemh-025-c51fb.png,img/2289/19532/seemh-026-de41.png,img/2289/19532/seemh-026-de41b.png,img/2289/19532/seemh-027-c470.png,img/2289/19532/seemh-027-c470b.png,img/2289/19532/seemh-028-c1ac.png,img/2289/19532/seemh-028-c1acb.png,img/2289/19532/seemh-029-e12a.png,img/2289/19532/seemh-029-e12ab.png,img/2289/19532/seemh-030-f5f3.png,img/2289/19532/seemh-030-f5f3b.png,img/2289/19532/seemh-031-9360.png,img/2289/19532/seemh-031-9360b.png,img/2289/19532/seemh-032-d00c.png,img/2289/19532/seemh-032-d00cb.png,img/2289/19532/seemh-033-a996.png,img/2289/19532/seemh-033-a996b.png,img/2289/19532/seemh-034-a616.png,img/2289/19532/seemh-034-a616b.png,img/2289/19532/seemh-035-e1b5.png,img/2289/19532/seemh-035-e1b5b.png,img/2289/19532/seemh-036-9f9d.png,img/2289/19532/seemh-036-9f9db.png,img/2289/19532/seemh-037-5d7e.png,img/2289/19532/seemh-037-5d7eb.png,img/2289/19532/seemh-038-aa5d.png,img/2289/19532/seemh-038-aa5db.png,img/2289/19532/seemh-039-81ce.png,img/2289/19532/seemh-039-81ceb.png,img/2289/19532/seemh-040-9b0e.png,img/2289/19532/seemh-040-9b0eb.png,img/2289/19532/seemh-041-b084.png,img/2289/19532/seemh-041-b084b.png,img/2289/19532/seemh-042-4606.png,img/2289/19532/seemh-042-4606b.png,img/2289/19532/seemh-043-7484.png,img/2289/19532/seemh-043-7484b.png,img/2289/19532/seemh-044-165e.png,img/2289/19532/seemh-044-165eb.png,img/2289/19532/seemh-045-01fe.png,img/2289/19532/seemh-045-01feb.png,img/2289/19532/seemh-046-3880.png,img/2289/19532/seemh-046-3880b.png,img/2289/19532/seemh-047-a567.png,img/2289/19532/seemh-047-a567b.png,img/2289/19532/seemh-048-56eb.png,img/2289/19532/seemh-048-56ebb.png,img/2289/19532/seemh-049-4a42.png,img/2289/19532/seemh-049-4a42b.png,img/2289/19532/seemh-050-15b5.png,img/2289/19532/seemh-050-15b5b.png,img/2289/19532/seemh-051-c6b7.png,img/2289/19532/seemh-051-c6b7b.png,img/2289/19532/seemh-052-4885.png,img/2289/19532/seemh-052-4885b.png,img/2289/19532/seemh-053-12f9.png,img/2289/19532/seemh-053-12f9b.png,img/2289/19532/seemh-054-5b9f.png,img/2289/19532/seemh-054-5b9fb.png,img/2289/19532/seemh-055-f64b.png,img/2289/19532/seemh-055-f64bb.png,img/2289/19532/seemh-056-43ff.png,img/2289/19532/seemh-056-43ffb.png,img/2289/19532/seemh-057-7eba.png,img/2289/19532/seemh-057-7ebab.png,img/2289/19532/seemh-058-f15c.png,img/2289/19532/seemh-058-f15cb.png,img/2289/19532/seemh-059-d1f4.png,img/2289/19532/seemh-059-d1f4b.png,img/2289/19532/seemh-060-c10d.png,img/2289/19532/seemh-060-c10db.png,img/2289/19532/seemh-061-3d9d.png,img/2289/19532/seemh-061-3d9db.png,img/2289/19532/seemh-062-3eee.png,img/2289/19532/seemh-062-3eeeb.png,img/2289/19532/seemh-063-d4f7.png,img/2289/19532/seemh-063-d4f7b.png,img/2289/19532/seemh-064-be05.png,img/2289/19532/seemh-064-be05b.png,img/2289/19532/seemh-065-9fa8.png,img/2289/19532/seemh-065-9fa8b.png,img/2289/19532/seemh-066-8b7f.png,img/2289/19532/seemh-066-8b7fb.png,img/2289/19532/seemh-067-9a45.png,img/2289/19532/seemh-067-9a45b.png,img/2289/19532/seemh-068-224a.png,img/2289/19532/seemh-068-224ab.png,img/2289/19532/seemh-069-fb6c.png,img/2289/19532/seemh-069-fb6cb.png,img/2289/19532/seemh-070-d7eb.png,img/2289/19532/seemh-070-d7ebb.png,img/2289/19532/seemh-071-cec7.png,img/2289/19532/seemh-071-cec7b.png,img/2289/19532/seemh-072-a0a5.png,img/2289/19532/seemh-072-a0a5b.png,img/2289/19532/seemh-073-9f08.png,img/2289/19532/seemh-073-9f08b.png,img/2289/19532/seemh-074-6e5e.png,img/2289/19532/seemh-074-6e5eb.png,img/2289/19532/seemh-075-bd3a.png,img/2289/19532/seemh-075-bd3ab.png,img/2289/19532/seemh-076-2e08.png,img/2289/19532/seemh-076-2e08b.png,img/2289/19532/seemh-077-0f7e.png,img/2289/19532/seemh-077-0f7eb.png,img/2289/19532/seemh-078-4121.png,img/2289/19532/seemh-078-4121b.png,img/2289/19532/seemh-079-a233.png,img/2289/19532/seemh-079-a233b.png,img/2289/19532/seemh-080-1334.png,img/2289/19532/seemh-080-1334b.png,img/2289/19532/seemh-081-4e61.png,img/2289/19532/seemh-081-4e61b.png,img/2289/19532/seemh-082-99d0.png,img/2289/19532/seemh-082-99d0b.png,img/2289/19532/seemh-083-d203.png,img/2289/19532/seemh-083-d203b.png,img/2289/19532/seemh-084-3d06.png,img/2289/19532/seemh-084-3d06b.png,img/2289/19532/seemh-085-377d.png,img/2289/19532/seemh-085-377db.png,img/2289/19532/seemh-086-a5c1.png,img/2289/19532/seemh-086-a5c1b.png,img/2289/19532/seemh-087-6a4c.png,img/2289/19532/seemh-087-6a4cb.png,img/2289/19532/seemh-088-a33f.png,img/2289/19532/seemh-088-a33fb.png,img/2289/19532/seemh-089-53a0.png,img/2289/19532/seemh-089-53a0b.png,img/2289/19532/seemh-090-76d6.png,img/2289/19532/seemh-090-76d6b.png,img/2289/19532/seemh-091-96ab.png,img/2289/19532/seemh-091-96abb.png,img/2289/19532/seemh-092-b243.png,img/2289/19532/seemh-092-b243b.png,img/2289/19532/seemh-093-c639.png,img/2289/19532/seemh-093-c639b.png,img/2289/19532/seemh-094-1ccb.png,img/2289/19532/seemh-094-1ccbb.png,img/2289/19532/seemh-095-5eb6.png,img/2289/19532/seemh-095-5eb6b.png,img/2289/19532/seemh-096-2413.png,img/2289/19532/seemh-096-2413b.png,img/2289/19532/seemh-097-03ce.png,img/2289/19532/seemh-097-03ceb.png,img/2289/19532/seemh-098-f39d.png,img/2289/19532/seemh-098-f39db.png,img/2289/19532/seemh-099-21e1.png,img/2289/19532/seemh-099-21e1b.png,img/2289/19532/seemh-100-e6ff.png,img/2289/19532/seemh-100-e6ffb.png,img/2289/19532/seemh-101-27ad.png,img/2289/19532/seemh-101-27adb.png,img/2289/19532/seemh-102-cf76.png,img/2289/19532/seemh-102-cf76b.png,img/2289/19532/seemh-103-aa39.png,img/2289/19532/seemh-103-aa39b.png,img/2289/19532/seemh-104-81ad.png,img/2289/19532/seemh-104-81adb.png,img/2289/19532/seemh-105-c4c1.png,img/2289/19532/seemh-105-c4c1b.png,img/2289/19532/seemh-106-7cc5.png,img/2289/19532/seemh-106-7cc5b.png,img/2289/19532/seemh-107-f646.png,img/2289/19532/seemh-107-f646b.png,img/2289/19532/seemh-108-0af4.png,img/2289/19532/seemh-108-0af4b.png,img/2289/19532/seemh-109-eb7a.png,img/2289/19532/seemh-109-eb7ab.png,img/2289/19532/seemh-110-b1de.png,img/2289/19532/seemh-110-b1deb.png,img/2289/19532/seemh-111-d436.png,img/2289/19532/seemh-111-d436b.png,img/2289/19532/seemh-112-818e.png,img/2289/19532/seemh-112-818eb.png,img/2289/19532/seemh-113-251e.png,img/2289/19532/seemh-113-251eb.png,img/2289/19532/seemh-114-e914.png,img/2289/19532/seemh-114-e914b.png,img/2289/19532/seemh-115-12ed.png"

MANHUAFEI_URL=https://feifei.mhtupian.com
MANHUAFEI_MANGA_URL=$MANHUAFEI_URL/uploads
MANGA_LIST=("${(@s/,/)MANGA_LIST_STR}")

# Downloading TOC
TMPDIR=/tmp/manhuafei-$MANGA

IFS=$'\012'
mkdir "$TMPDIR"
pushd "$TMPDIR"
  for image in "${MANGA_LIST[@]}"; do
    echo $image
    curl -O --output-dir "${TMPDIR}" --referer "$REFERER_URL" "${MANHUAFEI_MANGA_URL}/${image}"
  done

  zip -r "/tmp/$MANGA.cbz" *
  ls /tmp
popd
read

rm -rf "$TMPDIR"
