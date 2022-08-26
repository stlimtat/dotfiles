#!/bin/zsh
#
# Install command-line tools using Homebrew.
if [[ ! -d /usr/local/Homebrew ]]; then
    echo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
#
# Make sure we’re using the latest Homebrew.
brew tap homebrew/bundle
#
# Using brew bundle to install from Brewfile
# https://github.com/Homebrew/homebrew-bundle
brew bundle
#
# Remove outdated versions from the cellar.
brew cleanup
#
# Source for jenv from ~/.extra
source ~/.extra
#
# Install gvm
# https://github.com/moovweb/gvm
if [[ ! -d ${HOME}/.gvm ]]; then
    curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | /bin/zsh -
fi
#
# Install iterm shell integration
# https://iterm2.com/documentation-shell-integration.html
if [[ ! -d ${HOME}/.iterm2_shell_integration.zsh ]]; then
    curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
    source ~/.iterm2_shell_integration.zsh
fi
#
# iterm color schemes
# https://github.com/mbadolato/iTerm2-Color-Schemes
if [[ ! -d ${HOME}/go/src/github.com/mbadolato/iTerm2-Color-Schemes ]]; then
    mkdir -p ${HOME}/go/src/github.com/mbadolato
    git clone https://github.com/mbadolato/iTerm2-Color-Schemes ${HOME}/go/src/github.com/mbadolato/iTerm2-Color-Schemes
    pushd ${HOME}/go/src/github.com/mbadolato/iTerm2-Color-Schemes
        /bin/bash tools/import-scheme.sh "Solarized Darcula" "Solarized Dark - Patched" "Solarized Dark Higher Contrast"
    popd
fi
#
# Lunarvim
# Using https://www.lunarvim.org/
if [[ ! -f ${HOME}/.local/bin/lvim ]]; then
    curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | /bin/bash -
    ln -sf ${HOME}/.local/bin/lvim ${HOME}/bin/lvim
    rsync -ar $(pwd)/.config/ ${HOME}/.config/
    ${HOME}/bin/lvim +LvimUpdate +LvimCacheReset +'LspInstall pyright' +'TSInstall python' +q
    ${HOME}/bin/lvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    luarocks install luacheck
fi
#
# oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh
if [[ ! -d ${HOME}/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # https://github.com/jeffreytse/zsh-vi-mode
    if [[ ! -d ${HOME}/.oh-my-zsh/custom/plugins/zsh-vi-mode ]]; then
        git clone https://github.com/jeffreytse/zsh-vi-mode ${HOME}/.oh-my-zsh/custom/plugins/zsh-vi-mode
    fi
    # https://github.com/eendroroy/alien
    if [[ ! -d ${HOME}/.oh-my-zsh/custom/alien ]]; then
        git clone https://github.com/eendroroy/alien ${HOME}/.oh-my-zsh/custom/alien
        pushd ${HOME}/.oh-my-zsh/custom/alien
          git submodule update --init --recursive
        popd
    fi
fi
#
# python
# https://github.com/pyenv/pyenv
if [[ ! -d ${HOME}/.pyenv/versions ]]; then
    # PY_VER=$(pyenv install --list | grep "  3.10" | tail -n 1 | sed -e 's/ //g')
    # pyenv install ${PY_VER}
    # pyenv global ${PY_VER}
    pyenv install 3.8.8
    pyenv global 3.8.8
    eval "$(pyenv init --path)"
    pip install --upgrade pip
    pip install subliminal youtube-dl
    pip install flake8 pipenv pynvim vim-vint virtualenv yapf
fi

# Return the .zshrc.pre back to .zshrc
[ -f ${HOME}/.zshrc.pre* ] && mv ${HOME}/.zshrc.pre* ${HOME}/.zshrc
[ -f ${HOME}/*brew.sh ] && rm -rf ${HOME}/*brew.sh
