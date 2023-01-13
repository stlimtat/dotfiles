# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
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
  asdf
  colored-man-pages
  direnv
  docker
  docker-compose
  fzf
  gh
  golang
  helm
  zsh-vi-mode
)
# ~/.oh-my-zsh
start_time=$(gdate +%s%3N)
echo "Running oh-my-zsh...${start_time}ms"
source ${ZSH}/oh-my-zsh.sh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Running oh-my-zsh...${end_time}ms...${time_taken}ms...Done"
# zstyle
start_time=$(gdate +%s%3N)
echo "Running zstyle...${start_time}ms"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zstyle ':autocomplete:*' default-context history-incremental-search-backward
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Running zstyle...${end_time}ms...${time_taken}ms...Done"
fpath=(/usr/local/share/zsh-completions $fpath)
for file in ~/.{aliases,devenv,exports,extra,functions,path,tokens,abnormal}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

