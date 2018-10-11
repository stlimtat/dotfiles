#!/usr/local/bin/bash

while `test -z $(pgrep -f OneDrive)`; do
  sleep 10
done

if [ -z $(pgrep -f cputhrottle | head -n1) ]; then
  /usr/local/bin/cputhrottle \
      $(/usr/bin/pgrep -f OneDrive) \
      60
fi