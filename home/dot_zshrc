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
eval "$(/usr/local/bin/brew shellenv)"
export PATH="${HOME}/bin:$PATH"

# files
for file in ${HOME}/.{aliases,devenv,exports,extra,evals,functions,path,tokens}; do
  # files
  start_time=$(gdate +%s%3N)
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
  end_time=$(gdate +%s%3N)
  time_taken=$((end_time - start_time))
  echo "Load $file...${time_taken}ms...Done"
done
unset file

# oh-my-zsh
export ZSH=${HOME}/.oh-my-zsh
COMPLETION_WAITING_DOTS=true
HIST_STAMPS="yyyy-mm-dd"
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode auto
# ~/.oh-my-zsh/plugins/docker/README.md
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
# ~/.oh-my-zsh/plugins/eza/README.md
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'hyperlink' yes
zstyle ':omz:plugins:eza' 'icons' yes
zstyle ':omz:plugins:eza' 'size-prefix' 'si' 
# ~/.oh-my-zsh/plugins/fzf/README.md
export FZF=$(brew --prefix)/bin/fzf
# ~/.oh-my-zsh/plugins
plugins=(
  colored-man-pages
  docker
  eza
  fzf
  gcloud
  myfzf
)

# ~/.oh-my-zsh
start_time=$(gdate +%s%3N)
FPATH=/usr/share/zsh/$(zsh --version | awk '{ print $2 }')/functions
FPATH=/usr/share/zsh/site-functions:${FPATH}
FPATH=$(brew --prefix)/share/zsh/site-functions:${FPATH}
FPATH=$(brew --prefix)/share/zsh-completions:${FPATH}
source ${ZSH}/oh-my-zsh.sh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load oh-my-zsh...${time_taken}ms...Done"

# powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
start_time=$(gdate +%s%3N)
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
# ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ${HOME}/.p10k.zsh ]] || source ${HOME}/.p10k.zsh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load powerlevel10k...${time_taken}ms...Done"

# compinit
start_time=$(gdate +%s%3N)
rm -f ~/.zcompdump*
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load completion init...${time_taken}ms...Done"


# Added by Antigravity
export PATH="/Users/st_lim/.antigravity/antigravity/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/st_lim/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
