# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Map caps lock to delete-backspace
# https://apple.stackexchange.com/questions/7231/how-can-i-rebind-caps-lock-to-delete-backspace
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000002A}]}' >/dev/null 2>&1
tabs -2

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="${HOME}/bin:$PATH"

export ZSH=${HOME}/.oh-my-zsh
HIST_STAMPS="yyyy-mm-dd"
HYPHEN_INSENSITIVE="true"
# ~/.oh-my-zsh/plugins/vi-mode/README.md
# export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
# export VI_MODE_SET_CURSOR=true
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
  gh
  golang
  helm
  zsh-autosuggestions
  zsh-vi-mode
  zsh-syntax-highlighting
)
# ~/.oh-my-zsh
start_time=$(gdate +%s%3N)
echo "Running oh-my-zsh...${start_time}ms"
source ${ZSH}/oh-my-zsh.sh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Running oh-my-zsh...${end_time}ms...${time_taken}ms...Done"
fpath=(/usr/local/share/zsh-completions $fpath)
for file in ${HOME}/.{aliases,devenv,exports,extra,functions,path,tokens,abnormal}; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
start_time=$(gdate +%s%3N)
echo "Running p10k...${start_time}ms"
[[ ! -f ${HOME}/.p10k.zsh ]] || source ${HOME}/.p10k.zsh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Running p10k...${end_time}ms...${time_taken}ms...Done"
# fzf
start_time=$(gdate +%s%3N)
echo "Running fzf...${start_time}ms"
zvm_after_init_commands+=("[ -f ${HOME}/.fzf.zsh ] && source ${HOME}/.fzf.zsh")
source ${HOME}/.fzf.zsh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Running fzf...${end_time}ms...${time_taken}ms...Done"

