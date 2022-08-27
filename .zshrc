export PATH="$HOME/bin:$PATH";
export ZSH=${HOME}/.oh-my-zsh
HIST_STAMPS="yyyy-mm-dd"
HYPHEN_INSENSITIVE="true"
# ~/.oh-my-zsh/plugins/vi-mode/README.md
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true
ZSH_THEME="abnormal"
# ~/.oh-my-zsh/plugins/tmux/README.md
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOSTART_ONCE=true
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_AUTOQUIT=ZSH_TMUX_AUTOSTART
export ZSH_TMUX_ITERM2=true
export ZSH_TMUX_FIXTERM_WITH_256COLOR="screen-256color"
export ZSH_TMUX_UNICODE=true
plugins=(
  ag
  colored-man-pages
  docker
  docker-compose
  encode64
  gh
  golang
  iterm2
  rand-quote
  terraform
  urltools
  zsh-vi-mode
)
source $ZSH/oh-my-zsh.sh
# # https://github.com/eendroroy/alien
# export ALIEN_SECTIONS_LEFT=(
#   exit
#   battery
#   user
#   path
#   pyenv_version
#   vcs_branch:async
#   vcs_status:async
#   vcs_dirty:async
#   versions:async
#   newline
#   ssh
#   prompt
# )
# export ALIEN_SECTIONS_RIGHT=(
#   time
# )
# export ALIEN_SECTION_TIME_FORMAT="%F %T%z" # default is %r
# export ALIEN_THEME="gruvbox"
# export ALIEN_USE_NERD_FONT=1
# # export ALIEN_VERSIONS_PROMPT='GO NODE PYTHON RUBY'
# source ${ZSH}/custom/alien/alien.zsh
fpath=(/usr/local/share/zsh-completions $fpath)
for file in ~/.{aliases,devenv,exports,extra,functions,path,tokens,abnormal}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file
