# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="${HOME}/bin:$PATH"
export ZSH=${HOME}/.oh-my-zsh
HIST_STAMPS="yyyy-mm-dd"
HYPHEN_INSENSITIVE="true"
# ~/.oh-my-zsh/plugins/vi-mode/README.md
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="bullet-train"
# ~/.oh-my-zsh/plugins/tmux/README.md
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOSTART_ONCE=true
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_AUTOQUIT=ZSH_TMUX_AUTOSTART
export ZSH_TMUX_ITERM2=true
export ZSH_TMUX_FIXTERM_WITH_256COLOR="screen-256color"
export ZSH_TMUX_UNICODE=true
# ~/.oh-my-zsh/plugins
plugins=(
  ag
  colored-man-pages
  docker
  docker-compose
  encode64
  gh
  golang
  rand-quote
  terraform
  urltools
  zsh-vi-mode
)
# ~/.oh-my-zsh
start_time=$(gdate +%s%3N)
echo "Running oh-my-zsh...${start_time}ms"
source ${ZSH}/oh-my-zsh.sh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Running oh-my-zsh...${end_time}ms...${time_taken}ms...Done"
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
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
