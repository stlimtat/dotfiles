#!/usr/bin/env zsh
# sudo touchid
# https://apple.stackexchange.com/questions/259093/can-touch-id-on-mac-authenticate-sudo-in-terminal
sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
#
# Install fzf
[[ -f "$(brew --prefix)/opt/fzf/install" ]] && $(brew --prefix)/opt/fzf/install
# Adding keka
# https://github.com/aonez/Keka/wiki/Finder-Extension-on-macOS-15-Sequoia
pluginkit -m CFBundleIdentifier=com.aone.keka.KekaFinderIntegration -vv | grep UUID | awk '{ print $3 }' | pluginkit -e "use" -u -                                                                        ─╯
#
# matplotlib
mkdir ~/.matplotlib
cat > ~/.matplotlib/matplotlibrc <<EOF
backend: TkAgg
EOF
#
# hdf5 for arm processors
if [[ "$(uname -m)" != "x86_64" ]]; then
  cat > /opt/homebrew/lib/pkgconfig/hdf5.pc <<EOF
prefix=/opt/homebrew/opt/hdf5
libdir=${prefix}/lib
includedir=${prefix}/include

Name: hdf5
Description: File format designed to store large amounts of data
Version: 1.12.1
Libs: -L${libdir}
Cflags: -I${includedir}
EOF
fi
