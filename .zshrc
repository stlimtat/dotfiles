export PATH="$HOME/bin:$PATH";
export ZSH=${HOME}/.oh-my-zsh
ZSH_THEME="re5et"
HYPHEN_INSENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(
  docker
  docker-compose
  encode64
  git
  git-prompt
  golang
  iterm2
  jira
  kubectl
  rand-quote
  sudo
  terraform
  zsh-vi-mode
)
source $ZSH/oh-my-zsh.sh
fpath=(/usr/local/share/zsh-completions $fpath)
for file in ~/.{aliases,devenv,exports,extra,functions,path,tokens,abnormal}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file
