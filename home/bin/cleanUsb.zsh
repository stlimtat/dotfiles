#!/bin/zsh

USB=$1
USB_PATH=/Volumes/${USB}
if [ "${USB}" = "" -o ! -d ${USB_PATH} ]; then
				echo Cannot proceed
				exit 1
fi

sudo mdutil -i off -d ${USB_PATH}
sudo rm -rf ${USB_PATH}/.{,_.}{fseventsd,Spotlight-V*,Trashes} 2> /dev/null
mkdir ${USB_PATH}/.fseventsd
touch ${USB_PATH}/.fseventsd/no_log ${USB_PATH}/.metadata_never_index ${USB_PATH}/.Trashes
gfind ${USB_PATH} -name "._*" -delete
gfind ${USB_PATH} -name ".DS_Store" -delete
