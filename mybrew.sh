#!/bin/zsh

# Install command-line tools using Homebrew.
if [ ! -d /usr/local/Homebrew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Make sure we’re using the latest Homebrew.
brew tap homebrew/bundle

# Using brew bundle to install from Brewfile
# https://github.com/Homebrew/homebrew-bundle
brew bundle

# Remove outdated versions from the cellar.
brew cleanup

# Source for jenv from ~/.extra
source ~/.extra

# Install iterm shell integration
# https://iterm2.com/documentation-shell-integration.html
if [ ! -d ${HOME}/.iterm2_shell_integration.zsh ]; then
    curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
    source ~/.iterm2_shell_integration.zsh
fi

# Install oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh
if [ ! -d ${HOME}/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Link the vim
# Using https://github.com/amix/vimrc
if [ ! -d ${HOME}/.vim_runtime ]; then
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
    pushd ~/.vim_runtime
        python update_plugins.py
    popd
    mkdir -p ~/.config/nvim
    ln -sf ~/.vimrc ~/.config/nvim/init.vim
    cp init/my_configs.vim ~/.vim_runtime
fi

# https://github.com/jeffreytse/zsh-vi-mode
if [ ! -d ${ZSH}/custom/plugins/zsh-vi-mode ]; then
    git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode
fi

# Return the .zshrc.pre back to .zshrc
mv ${HOME}/.zshrc.pre* ${HOME}/.zshrc

