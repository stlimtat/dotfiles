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
# ~/.oh-my-zsh/plugins/fzf/README.md
export FZF=$(brew --prefix)/bin/fzf
# ~/.oh-my-zsh/plugins
plugins=(
  colored-man-pages
  docker
  eza
  fzf
  poetry
)

# ~/.oh-my-zsh
start_time=$(gdate +%s%3N)
FPATH=/usr/share/zsh/$(zsh --version | awk '{ print $2 }')/functions
FPATH=/usr/share/zsh/site-functions:${FPATH}
FPATH=/usr/local/share/zsh/site-functions:${FPATH}
FPATH=$(brew --prefix)/share/zsh/site-functions:${FPATH}
FPATH=$(brew --prefix)/share/zsh-completions:${FPATH}
FPATH=${HOME}/.config/zsh:${FPATH}
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
for file in ${HOME}/.{aliases,devenv,exports,extra,functions,path,tokens}; do
  # files
  start_time=$(gdate +%s%3N)
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
  end_time=$(gdate +%s%3N)
  time_taken=$((end_time - start_time))
  echo "Load $file...${time_taken}ms...Done"
done
unset file

# batman
start_time=$(gdate +%s%3N)
eval "$(batman --export-env)"
eval "$(batpipe)"
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load batman...${time_taken}ms...Done"

# fzf
start_time=$(gdate +%s%3N)
zvm_after_init_commands+=("$(fzf --zsh)")
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' 
  --preview-window down:3:hidden:wrap 
  --bind '?:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load fzf...${time_taken}ms...Done"

# 1password
start_time=$(gdate +%s%3N)
source ${HOME}/.config/op/plugins.sh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load 1password...${time_taken}ms...Done"

# zsh-autopair
start_time=$(gdate +%s%3N)
source $(brew --prefix)/share/zsh-autopair/autopair.zsh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load zsh-autopair...${time_taken}ms...Done"

# zsh-autosuggestions
start_time=$(gdate +%s%3N)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load zsh-autosuggestions...${time_taken}ms...Done"

# zsh-fast-syntax-highlighting
start_time=$(gdate +%s%3N)
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load zsh-fast-syntax-highlighting...${time_taken}ms...Done"

# zsh-system-clipboard
start_time=$(gdate +%s%3N)
source $(brew --prefix)/share/zsh-system-clipboard/zsh-system-clipboard.zsh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load zsh-system-clipboard...${time_taken}ms...Done"

# zsh-vi-mode
start_time=$(gdate +%s%3N)
source $(brew --prefix)/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
end_time=$(gdate +%s%3N)
time_taken=$((end_time - start_time))
echo "Load zsh-vi-mode...${time_taken}ms...Done"

