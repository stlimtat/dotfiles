#!/usr/local/bin/bash

USB=$1
USB_PATH=/Volumes/${USB}
if [ "${USB}" = "" -o ! -d ${USB_PATH} ]; then
				echo Cannot proceed
				exit 1
fi

mdutil -i off ${USB_PATH}
rm -rf ${USB_PATH}/.{,_.}{fseventsd,Spotlight-V*,Trashes}
mkdir ${USB_PATH}/.fseventsd
touch ${USB_PATH}/.fseventsd/no_log ${USB_PATH}/.metadata_never_index ${USB_PATH}/.Trashes